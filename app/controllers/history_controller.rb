class HistoryController < ApplicationController
  before_action :load_history, only: :index
  
  def index; end

  def update
    if current_user
      history = current_user.histories.find_by(chapter_id: params[:chapter])
    end

    history.update_attributes(position: params[:pos]) if history
  end
end
