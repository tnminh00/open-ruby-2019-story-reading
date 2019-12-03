class StoriesController < ApplicationController
  before_action :load_story, only: :show

  def index
    @stories = Story.page(params[:page]).per Settings.perpage
  end

  def show
    @chapters = @story.chapters.page params[:page]
  end

  private

  def story_params
    params.requires(:stories).permit Story::STORY_PARAMS
  end

  def load_story
    @story = Story.find_by id: params[:id]
    
    return if @story
    
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
