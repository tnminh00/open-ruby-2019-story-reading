class Chapter < ApplicationRecord
  CHAPTER_PARAMS = %i(name chapter_number content).freeze

  belongs_to :story
  has_many :histories
  has_many :users, through: :histories
  has_many :comments, as: :commentable
  validates :name, presence: true
  validates :chapter_number, presence: true, numericality: {greater_than: 0}
  validates :content, presence: true

  delegate :name, to: :story, prefix: true

  scope :order_chapter, -> {order chapter_number: :desc}

  def next_chapter
    story.chapters.find_by(chapter_number: self.chapter_number + 1)
  end

  def previous_chapter
    story.chapters.find_by(chapter_number: self.chapter_number - 1)
  end

  def date_time
    updated_at.strftime Settings.date_format
  end
end
