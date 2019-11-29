class CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per Settings.perpage
  end

  def show
    @category = Category.find_by id: params[:id]

    if @category.exists?
      @title = @category.name
      @stories = @category.stories.page params[:page]
    else
      flash[:danger] = t ".danger"
      redirect_to root_path
    end
  end

  private

  def category_params
    params.requires(:categories).permit :name
  end
end
