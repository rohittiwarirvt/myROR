class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :show, :destroy, :update]
  before_action :course_categories, only: [:new, :edit, :create]


  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
    @version = @course.versions.build
    @version_role = @version.version_roles.build
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      @course.versions.first.version_roles<< version_role_init unless roles_params.blank?
      set_flash_message :success, :success
      redirect_to syllabus_version_path(@course.versions.first)
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
    @version = @course.versions.last
    @version_roles = @version.version_roles
  end

  def show

  end

  def update
    version = @course.versions.last
    if @course.update(course_params)
      version.update_role(version_role_init)
      redirect_to syllabus_version_path(@course.versions.first)
    else
      redirect_to edit_course_path
    end
  end

  def destroy
    if @course
      @course.destroy
      set_flash_message :notice, :destroy
    else
      set_flash_message :notice, :failure
    end
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_categories
    @categories = Category.order('name')
  end

  def version_role_init
    roles_params.map{ |id| [Role.find(id)]}
  end
  private
    def course_params
      params.require(:course).permit(:id, :name, versions_attributes:[:id,
      :description, :image, :category_id, :image, :video, :expiry, :price,
      :amount, :short_description, :prerequisite])
    end

    def roles_params
      role_ids =nil
      params[:course][:versions_attributes].values.each do |item|
        role_ids = item[:version_role_ids]
      end if params[:course] and params[:course][:versions_attributes]
      role_ids.reject(&:empty?)
    end


end



