class User < ApplicationRecord
  has_many :comments
  has_many :rates
  has_many :follows
  has_many :stories, through: :follows
  has_many :histories
  has_many :chapters, through: :histories
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.email.maximum}, 
    format: {with: Settings.valid_email_regex}, uniqueness:true
  validates :password, presence: true,
    length: {minimum: Settings.password.minimum}, allow_nil: true
  has_secure_password

  USER_PARAMS = %i(name email password password_confirmation).freeze
end
