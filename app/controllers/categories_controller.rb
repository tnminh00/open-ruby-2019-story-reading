class CategoriesController < ApplicationController
  before_action :load_category, only: :show

  def index
    @categories = Category.page(params[:page]).per Settings.perpage
  end

  def show
    @stories = @category.stories.page params[:page]
  end

  private

  def category_params
    params.requires(:categories).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]

    if @category.present?
      @title = @category.name
    else
      flash[:danger] = t ".danger"
      redirect_to root_path
    end
  end
end
