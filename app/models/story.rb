class Story < ApplicationRecord
  STORY_PARAMS = %i(name author introduction).freeze

  has_many :chapters, dependent: :destroy
  has_many :category_stories
  has_many :categories, through: :category_stories
  has_many :comments, as: :commentable
  has_many :follows
  has_many :users, through: :follows
  ratyrate_rateable "rating"

  validates :name, presence: true, length: {maximum: Settings.story.name_maximum}
  validates :author, presence: true, length: {maximum: Settings.story.author_maximum}
  validates :introduction, presence: true, length: {maximum: Settings.story.introduction_maximum}

  scope :search_by_name, -> name {where "name like ?", "#{name}%"}

  def new_chapter
    self.lastest_chapter + 1
  end

  def lastest_chapter
    chapters.lastest_chapter
  end
end
