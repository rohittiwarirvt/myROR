class PresentationsController < ApplicationController
  layout 'application'
  before_action :course_section, :chapter_name, only: [:new, :create]

  def new
    @presentation = Presentation.new(course_section_params)
    @slide = Slide.new
  end

  def create
    @presentation = @course_section.build_presentation(presentation_params)

  end

  def presentation_params
    params.require(:presentation).permit(
      :title, :version_id, :slides_attributes, [:number_of_columns]
      )
  end

  def course_section_params
    params.permit(:course_section_id)
  end

  def course_section
    @course_section = CourseSection.find(params[:course_section_id])
  end

  def chapter_name
    @chapter_name = @course_section.chapter.name if @course_section.chapter
  end
end
