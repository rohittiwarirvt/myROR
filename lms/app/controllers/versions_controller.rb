class VersionsController < ApplicationController

  before_action :set_version, only: [:show, :edit, :update, :destroy, :publish, :preview, :editable]

  def index
    @versions = Version.all
  end

  def show
    @course = @version.course
    @chapter = CourseSection.new
    @chapters = @version.chapters
  end

  def new
    @version = Version.new
  end

  def edit
    @chapters = @version.chapters
  end

  def create
    @version = Version.new(version_params)
    if @version.save
      set_flash_message :notice, :success
      redirect_to version_path
    else
      render :edit
    end
  end

  def update
    if @version.update(version_params)
      set_flash_message :notice, :success
      redirect_to version_path
    else
      render :edit
    end

  end

  def destroy
    if @version.published
      set_flash_message :danger, :failure
    else
      @version.try(:destroy) && set_flash_message(:notice, :destroy)
    end
    redirect_to versions_path
  end

  def editable
    editable = !@version.editable
    publish_result = @version.published
    if editable
      @version.user_courses.destroy_all
      @version.update_attributes(editable:true)
    end
    render json: {editable: editable, publish_result: publish_result}
  end

  def preview
    #preview_user_id = { user_id: CourseTaking::UserCourse.preview_user_id}
    #preview = @version.user_courses.find_or_create_by(preview_user_id)
    #redirect_to course_taking_preview_path(course_id: preview.id)
  end

  private
    def set_version
      @version = Version.find(params[:id])
    end

    def version_params
      params.require(:version).permit(:description, :image, :video, :expiry,
       :prerequisite, :course_id, :category_id)
    end
end
