class CourseSectionsController < ApplicationController
  before_action :set_course_section, except: [:new, :create]
  before_action :set_version

  def new
    @course_section = CourseSection.new
    @cs = params[:cs] ? params[:cs] : 'new'
    @chapter = CourseSection.find(params[:cs]) unless @cs == 'new'
  end

  def create
    #debugger
    set_chapters
    @course_section = @version.course_sections.new(course_section_params)
    @course_section.save ? refresh_syllabus : render_notice(errors)
  end

  private

  def set_chapters
    @chapters = @version.course_sections.chapters.rank(:course_order)
  end

  def course_section_params
    params.require(:course_section).permit(:name, :parent_id,
                                           :course_order_position,
                                            :chapter_order_position)
  end

  def set_version
    @version = Version.find(params[:version_id])
  end

  def refresh_syllabus
    set_chapters if @chapters.blank?
    respond_to do |format|
      format.js { render file: '/course_sections/syllabus.js.coffee'}
    end
  end

end

