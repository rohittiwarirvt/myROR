require 'zip'
class CustomContentsController < ApplicationController
  before_action :set_customcontent, only: [:show, :edit, :update, :destroy]
  before_action :set_version, except: [:show]

  def index
    @customcontent = CustomContent.all
  end

  def new
    @customcontent = CustomContent.new
  end

  def create
    @customcontent = CustomContent.new(customcontent_params)
    @customcontent.course_section_id = params[:course_section_id];
    if @customcontent.save && @customcontent.unzip(customcontent_params)
      @customcontent.sectionize_content
      set_flash_message :success, :success
      redirect_to syllabus_version_path(@version)
    else
      FileUtils.rm_rf(@customcontent.zip.path[0..-5])
      @customcontent.destroy!
      set_flash_message :danger, :indexpage
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def set_customcontent
    @customcontent = CustomContent.find(params[:id]);
  end

  def customcontent_params
    params.require(:custom_content).permit(:name, :zip)
  end

  def set_version
    @version = Version.find(params[:version_id])
  end
end
