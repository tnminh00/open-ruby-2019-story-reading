class Story < ApplicationRecord
  STORY_PARAMS = %i(name author introduction).freeze
  ORDERS = %i(name rating follow view).freeze

  has_many :chapters, dependent: :destroy
  has_many :category_stories
  has_many :categories, through: :category_stories
  has_many :comments, as: :commentable
  has_many :follows, dependent: :destroy
  has_many :users, through: :follows
  has_one :rate_average, -> { where dimension: "rating"}, as: :cacheable, class_name: RatingCache.name, dependent: :destroy
  ratyrate_rateable "rating"

  validates :name, presence: true, length: {maximum: Settings.story.name_maximum}
  validates :author, presence: true, length: {maximum: Settings.story.author_maximum}
  validates :introduction, presence: true, length: {maximum: Settings.story.introduction_maximum}

  scope :order_by_name, -> {order name: :asc}
  scope :order_by_view, -> {order total_view: :desc}
  scope :order_by_follow, -> {left_outer_joins(:follows).group(:id).order("count(follows.user_id) desc")}
  scope :order_by_rating, -> {order("rating_caches.avg desc")}
  scope :relative_intro, -> {includes(:categories).includes(:chapters).includes(:follows).includes(:rate_average)}

  def new_chapter
    self.lastest_chapter + 1
  end

  def lastest_chapter
    chapters.lastest_chapter
  end
end
