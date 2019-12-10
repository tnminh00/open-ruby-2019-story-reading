class ChaptersController < ApplicationController
  before_action :check_is_admin, except: %i(index show)
  before_action :load_story, only: :create
  before_action :load_chapter, except: %i(index new create)

  def show
    Story.increment_counter :total_view, @chapter.story_id
  end

  def destroy
    @chapter.destroy

    if @chapter.destroyed?
      flash[:success] = t ".del_success"
    else
      flash[:danger] = t ".del_fail"
    end
    redirect_to story_path(@chapter.story)
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
    @story = Story.find_by(id: params[:story][:id])
    @chapter = @story.chapters.new chapter_params

    if @story.chapters.where(chapter_number: chapter_params[:chapter_number]).exists?
      if @chapter.save
        flash[:success] = t ".success"
        redirect_to story_path(@chapter.story)
      else
        render :new
      end
    else
      flash[:danger] = t ".unsuccess"
      redirect_back(fallback_location: root_path)
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
    @story = Story.find_by(id: params[:story][:id])

    return if @story

    flash[:danger] = t ".danger2"
    redirect_to root_path
  end
end
