class CommentsController < ApplicationController 
  before_action :load_comment, only: :destroy

  def create
    load_story params[:story] 
    @comment = @story.comments.new(content: params[:content])
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html {redirect_to @story}
        format.js
      end
    else
      respond_to do |format|
        format.js {render "alert(I18n.t('comments.fail'))"}
      end
    end
  end

  def destroy
    load_story @comment.commentable_id

    if @comment.destroy
      respond_to :html, :js
    else
      respond_to do |format|
        format.js {render "alert(I18n.t('comments.fail'))"}
      end
    end

    @comments = @story.comments.order_by_create.page(params[:comment_page]).per Settings.comments
  end

  private

  def load_story story_id
    @story = Story.find_by id: story_id

    return if @story

    flash[:danger] = t ".danger_story"
    redirect_to root_path
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]

    return if @comment

    flash[:danger] = t ".danger_comment"
    redirect_to root_path
  end
end
