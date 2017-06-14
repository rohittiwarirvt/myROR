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
    debugger
    @course = Course.new(course_params)

    if @course.save
      @course.versions.version_roles.build()
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
    @roles = Role.order('title')
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_categories
    @categories = Category.order('name')
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

role_id => [3,4,5]
