class StoriesController < ApplicationController
  def index
    @stories = Story.page(params[:page]).per Settings.perpage
  end
end
