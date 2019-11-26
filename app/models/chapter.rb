class Chapter < ApplicationRecord
  belongs_to :story
  has_many :histories
  has_many :users, through: :histories
  has_many :comments, as: :commentable
end
