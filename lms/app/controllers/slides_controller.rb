class SlidesController < ApplicationController

  before_action :set_slide, except: [ :new, :create]
  before_action :set_presentation
  before_action :set_slide_settings, only: [:edit, :update, :destroy]
  before_action :course_section, :version, only: [:new, :update, :destroy, :edit, :create, :slide_clone]

  def new
    @slide = Slide.new
  end

  def create
    slide = @presentation.slides.build(slide_params)
    if slide.save
      redirect_to edit_version_course_section_presentation_slide_path(@version,
       @course_section, @presentation, slide)
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  def update_settings
  end

  def update_contents
  end

  def delete_bg_img
  end

  def update_ppt_title
  end

  def update_title
  end

  def destroy_column
  end

  def slide_clone
  end

  def apply_settings
  end

  def set_presentation
    @presentation = Presentation.find(params[:presentation_id])
    @slides = @presentation.slides.rank(:slides_order)
  end

  def set_slide_settings
    @slide_contents = @slide.slide_contents.order(:orientation)
    @slide_setting = @slide.slide_setting
  end

  def set_slide
    @slide = Slide.find(params[:id])
  end

  def slide_params

  end

  def slide_settings_params
  end

  def slide_contnet_params
  end

  def slide_title_params
  end

  def edit_render
  end

  def delete_column(id)
  end

  def file_url(index)
  end

  def delete_column_params
  end

  def course_section
    @course_section = CourseSection.find(params[:course_section_id])
  end

  def version
    @version = Version.find(params[:version_id])
  end

  def section_names
    @chapter_name = @course_section.chapter.name if @course_section.chapter
  end


end
