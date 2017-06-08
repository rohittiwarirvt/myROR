class CoursesController < ApplicationController

  def index

  end

  def new
    @course = Course.new
    @version = @course.version.build
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

end
