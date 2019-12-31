class SearchController < ApplicationController
  def index
    if params[:search].present?
      @stories = Story.ransack(name_or_author_cont: params[:search]).result.page(params[:page])
      respond_to :js, :html
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
