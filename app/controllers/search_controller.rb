class SearchController < ApplicationController
  def index
    if params[:form_search].present?
      @stories = Story.search_by_name(params[:form_search]).page(params[:page]).per Settings.perpage
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
