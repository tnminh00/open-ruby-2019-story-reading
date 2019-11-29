class Chapter < ApplicationRecord
  belongs_to :story
  has_many :histories
  has_many :users, through: :histories
  has_many :comments, as: :commentable

  delegate :name, to: :story, prefix: true

  def next_chapter
    story.chapters.find_by(chapter_number: self.chapter_number + 1)
  end

  def previous_chapter
    story.chapters.find_by(chapter_number: self.chapter_number - 1)
  end
end
