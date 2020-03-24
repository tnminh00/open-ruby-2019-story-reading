class FollowsController < ApplicationController
  def index
    if current_user
      @stories = current_user.stories.page(params[:page]).per Settings.perpage
    else
      flash[:danger] = t ".danger"
      redirect_to new_user_session_path
    end
  end

  def create
    @story = Story.find_by id: params[:story_id]
    
    if @story
      current_user.follow @story if current_user
    else
      flash[:danger] = t ".not_found"
      redirect_to root_path
    end

    respond_to :js
  end

  def destroy
    @follow = Follow.find_by id: params[:id]
    
    if @follow
      @story = Story.find_by id: @follow.story_id
      current_user.unfollow @follow.id if current_user
    else
      flash[:danger] = t ".not_found"
      redirect_to root_path
    end

    respond_to :js
  end
end
