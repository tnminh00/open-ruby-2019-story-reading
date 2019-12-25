class HomePageController < ApplicationController
  before_action :check_is_admin, only: :management
  before_action :load_stories

  def home; end

  def management; end

  private

  def load_stories
    @stories = Story.page(params[:page]).per Settings.number_stories
  end
end
