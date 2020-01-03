class StoriesController < ApplicationController
  before_action :check_is_admin, except: %i(index show)
  before_action :load_story, except: %i(index new create)

  def index
    @stories = Story.relative_intro
    sort = Story::ORDERS.include?(params[:sort]) ? params[:sort] : :name

    unless params[:category].blank?
      categories = Category.find_by id: params[:category]
      if categories
        @stories = categories.stories
      else
        flash[:danger] = t ".no_category"
        redirect_to stories_path
      end
    end
      
    @stories = @stories.send("order_by_#{sort}").page(params[:page]).per Settings.perpage
  end

  def show
    @chapters = @story.chapters.order_chapter.page(params[:page]).per Settings.perpage
    @categories = @story.categories.page(params[:page]).per Settings.perpage
  end

  def destroy
    @story.destroy

    if @story.destroyed?
      flash[:success] = t ".del_success"
    else
      flash[:danger] = t ".del_fail"
    end
    redirect_to management_path
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new story_params
    add_categories

    if @story.save
      flash[:success] = t ".success"
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @story.update story_params
      update_categories
      flash[:success] = t ".success"
      render :edit
    else
      render :edit
    end
  end

  private

  def story_params
    params.require(:story).permit Story::STORY_PARAMS
  end

  def add_categories
    params[:category][:ids].shift
    params[:category][:ids].each do |cat|
      @story.category_stories.build category_id: cat
    end
  end

  def update_categories
    @story.category_stories.destroy_all
    params[:category][:ids].shift
    params[:category][:ids].each do |cat|
      @story.category_stories.create category_id: cat
    end
  end
end
