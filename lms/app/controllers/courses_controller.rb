class CoursesController < ApplicationController
  before_action :version_roles, only: [:edit, :new, :create]
  before_action :set_course, only: [:edit, :show, :destroy, :update]
  before_action :course_categories, only: [:new, :edit, :create]


  def index

  end

  def new
    #debugger
    @course = Course.new
    @version = @course.versions.build

  end

  def create

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
    @roles = Role.order('name')
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_categories
    @categories = Category.order('name')
  end

end
