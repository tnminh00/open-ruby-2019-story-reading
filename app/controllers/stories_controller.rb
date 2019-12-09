class StoriesController < ApplicationController
  before_action :load_story, only: %i(show destroy edit)
  before_action :check_is_admin, only: :destroy

  def index
    @stories = Story.page(params[:page]).per Settings.perpage
  end

  def show
    @chapters = @story.chapters.page params[:page]
    @categories = @story.categories.page(params[:page]).per Settings.perpage 
  end

  def destroy
    @story.destroy

    if @story.destroyed?
      flash[:success] = t ".del_success"
    else
      flash[:danger] = t ".del_fail"
    end
    redirect_to stories_path
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
