class ResourcesController < ApplicationController

  before_action :set_resource, except: [:index, :new, :create]
  before_action :set_type
  before_action :set_version
  before_action :set_section, if: :upload?, except: [:upload]
  before_action :set_chapters, only: [:index, :create, :update]

  def index

  end

  def new
    @resource = resource_class.new(section_params)
    respond_to do |format|
      format.js { render file: 'resources/new_content.js.coffee'}
      format.html
    end
  end

  def create

  end

  def edit

  end

  def update

  end

  def update_details

  end

  def destroy

  end

  def set_type
    @type = Resource.valid_type?( params[:type]) ? params[:type] : 'Resource'
  end

  def video_type
  end

  def resource_class
    "#{@type}".constantize
  end

  def resource_params
  end

  def update_params
  end

  def section_params
    params.permit(:course_section_id)
  end

  def set_section
    @section = CourseSection.find(params[:course_section_id])
  end

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def set_version
    @version = Version.find(params[:version_id])
  end

  def set_chapters
    @chapters = @version.chapters
  end

  def upload?
    Resource.upload?(params[:type])
  end

  def syllabus?
  end

  def resource_redirect_path
  end

end
