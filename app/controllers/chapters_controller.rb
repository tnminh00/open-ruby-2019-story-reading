class ChaptersController < ApplicationController
  before_action :check_is_admin, except: :show
  before_action :load_story, only: :create
  before_action :load_chapter, except: %i(index new create)

  def index
    @story = Story.find_by id: params[:id]
    if @story
      @chapters = @story.chapters
    else
      flash[:danger] = t ".danger2"
      redirect_to management_path
    end
  end

  def show
    Story.increment_counter :total_view, @chapter.story_id
    update_history

    if current_user
      @history = current_user.histories.find_by(chapter_id: params[:id])
    end
  end

  def destroy
    @chapter.destroy

    if @chapter.destroyed?
      flash[:success] = t ".del_success"
    else
      flash[:danger] = t ".del_fail"
    end
    redirect_to chapters_story_path @chapter.story
  end

  def edit; end

  def update
    if @chapter.update chapter_params
      flash[:success] = t ".success"
      redirect_to @chapter
    else
      render :edit
    end
  end

  def new
    @chapter = Chapter.new
  end

  def create
    users_follow = @story.users
    @chapter = @story.chapters.new chapter_params

    if @story.chapters.by_chapter_number(chapter_params[:chapter_number]).exists?
      flash[:danger] = t ".unsuccess"
      redirect_to chapters_story_path @story
    elsif @chapter.save
      flash[:success] = t ".success"
      redirect_to chapters_story_path @chapter.story
      if users_follow.exists?
        users_follow.each do |user|
          notification = user.notifications.create event: t(".noti", story: @story.name, number: chapter_params[:chapter_number])
          ActionCable.server.broadcast "notification_channel_#{user.id}",
            notification: render_notification(notification), counter: user.notifications.unseen.size
        end
      end
    else
      render :new
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit Chapter::CHAPTER_PARAMS
  end

  def load_chapter
    @chapter = Chapter.find_by id: params[:id]

    return if @chapter

    flash[:danger] = t ".danger"
    redirect_to stories_path
  end

  def load_story
    @story = Story.find_by id: params[:story][:id]

    return if @story

    flash[:danger] = t ".danger2"
    redirect_to root_path
  end

  def update_history
    if current_user
      related_chapter_ids = @chapter.story.chapter_ids
      history_chapter_ids = current_user.histories.pluck :chapter_id
      history_story_ids = Chapter.where(id: history_chapter_ids).pluck :story_id 

      unless history_story_ids.detect{|id| id == @chapter.story_id}
        current_user.histories.create chapter_id: params[:id]
      else
        current_user.histories.find_by(chapter_id: related_chapter_ids).update_attributes chapter_id: params[:id]
      end
    end
  end
end
