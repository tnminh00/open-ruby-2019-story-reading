class HomePageController < ApplicationController
  before_action :check_is_admin, only: :management

  def home
    @stories = Story.relative_intro.page(params[:page]).per Settings.number_stories
  end

  def management
    @stories = Story.all
  end
end
