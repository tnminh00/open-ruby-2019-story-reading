class ChaptersController < ApplicationController
  before_action :load_chapter, only: :show

  def show; end

  private

  def load_chapter
    @chapter = Chapter.find_by id: params[:id]

    return if @chapter

    flash[:danger] = t ".danger"
    redirect_to stories_path
  end
end
