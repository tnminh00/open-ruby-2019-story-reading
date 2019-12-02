class HomePageController < ApplicationController
  def home 
    @stories = Story.page(params[:page]).per Settings.number_stories
  end
end
