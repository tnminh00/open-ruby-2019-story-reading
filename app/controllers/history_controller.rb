class HistoryController < ApplicationController
  def index
    if current_user
      chapter_id = current_user.histories.pluck :chapter_id
      @chapters = Chapter.where(id: chapter_id)
    else
      redirect_to login_path
    end
  end
end
