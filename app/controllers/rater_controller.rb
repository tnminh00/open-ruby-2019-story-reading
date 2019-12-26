class RaterController < ApplicationController
  before_action :load_story, only: :create

  def create
    if current_user
      @story.rate params[:score].to_f, current_user, params[:dimension]

      render json: true
    else
      render json: false
    end
  end
end
