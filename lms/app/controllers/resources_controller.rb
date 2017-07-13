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
    @resource = resource_class.new(resource_params)
    if @resource.save
      @resource.sectionize_content(foreign_key: :content_section_id) if syllabus?
      respond_to do |format|
        format.json do
          render json: {status: true, version_id: params[:version_id]}
        end
      end
    elsif syllabus?
      render_notice(@resource.errors.full_message.join(','))
    else
      respond_to do |format|
        format.json do
          render json: { status: false,
            error: @resource.errors.messages[:base]
          }
        end
        forma.html {render :new}
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render file: 'resource/new_content.js.coffee'}
      format.html
    end
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
    params.require(set_type.downcase).permit(:file, :title, :type, :content, :version_id,
                                             :chapter_order_position, :version_order_position,
                                             :description, :course_section_id)
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
    params[:syllabus] || @resource.try(:course_section_id)
  end

  def resource_redirect_path
  end

end
