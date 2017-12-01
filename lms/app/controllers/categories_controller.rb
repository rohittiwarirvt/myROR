class CategoriesController < ApplicationController
  layout 'fullpage'
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @category = Category.all
  end

  def edit
  end

  def new
    @category = Category.new
  end

  def update
    if @category.update(category_params)
      set_flash_message :success, :update
    else
      set_flash_message :danger, :save_error
    end
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      respond_to do |format|
        format.json do
          render json: {
            status: true, id: @category.id,
            name: @category.name,
            notice: t('categories.success')
          }
        end
        format.html do
          redirect_to categories_path, flash: { notice: t('categories.success')}
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: {
            status: false,
            notice: @category.errors.messages[:name].first
          }
        end
      end
    end
  end
end
