class HistoryController < ApplicationController
  def index
    if current_user
      @chapters = current_user.chapters.page(params[:page]).per Setting.perpage
    else
      redirect_to login_path
    end
  end
end
