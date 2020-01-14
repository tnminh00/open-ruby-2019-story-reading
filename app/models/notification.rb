class Notification < ApplicationRecord
  belongs_to :user
  enum status: [:unseen, :seen]

  scope :order_by_create, -> {order created_at: :desc}
end
