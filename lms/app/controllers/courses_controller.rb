class CoursesController < ApplicationController
  before_action :version_roles, only: [:edit, :new, :create]
  before_action :set_course, only: [:edit, :show, :destroy, :update]
  before_action :course_categories, only: [:new, :edit, :create]


  def index
    @courses = Course.all
  end

  def new
    #debugger
    @course = Course.new
    @version = @course.versions.build

  end

  def create
    @course = Course.new(course_params)
    debugger
    if @course.save && VersionRole.create(version_user_roles_params)
      set_flash_message :success, :success
      redirect_to @course
    else
      @user_role_ids = role_params
      respond_to do |format|
        format.json do
          render json: {status: false, notice: @course.errors.messages[:title].first}
        end
        format.html { render :new}
      end
    end
  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  def version_roles
    #@user_role_ids ||= ''
    @roles = Role.order('title')
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_categories
    @categories = Category.order('name')
  end

  def version_user_roles_params
    version_user_roles = []
    if params[:role_id].present?
      params[:role_id].each do |role_id|
        version_role_hash = {
          role_id: role_id,
          version_id: @course.versions.last.id
        }
        version_user_roles.push(version_role_hash)
      end
    end
    version_user_roles
  end

  private
    def course_params
      params.require(:course).permit(:id, :name, versions_attributes:[:id,
      :description, :image, :category_id, :image, :video, :expiry, :price,
      :amount, :short_description, :prerequisite])
    end

    def role_params
      params.fetch(:role_id, '')
    end


end


