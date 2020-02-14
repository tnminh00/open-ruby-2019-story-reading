class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true 

  scope :order_by_create, -> {order created_at: :desc}

  delegate :name, to: :user, prefix: true
end
