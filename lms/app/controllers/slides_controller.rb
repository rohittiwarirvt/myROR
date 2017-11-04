class SlidesController < ApplicationController

  before_action :set_slide, except: [ :new, :create]
  before_action :set_presentation
  before_action :set_slide_settings, only: [:edit, :update, :destroy]
  before_action :course_section, :version, only: [:new, :update, :destroy, :edit, :create, :slide_clone]

  def new
  end

  def create
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
  end

  def set_slide_settings
  end

  def set_slide
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
  end

  def version
  end

  def section_names
  end


end
