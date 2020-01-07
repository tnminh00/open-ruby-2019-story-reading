class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email

  has_many :comments
  has_many :follows
  has_many :stories, through: :follows
  has_many :histories
  has_many :chapters, through: :histories
  has_many :notifications
  ratyrate_rater
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.email.maximum}, 
    format: {with: Settings.valid_email_regex}, uniqueness:true
  validates :password, presence: true,
    length: {minimum: Settings.password.minimum}, allow_nil: true
  has_secure_password

  USER_PARAMS = %i(name email password password_confirmation).freeze

  class << self
    def digest string
      if ActiveModel::SecurePassword.min_cost
        cost = BCrypt::Engine::MIN_COST
      else
        cost = BCrypt::Engine.cost
      end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest.present?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow story
    stories << story
  end

  def unfollow follow_relation
    follows.destroy follow_relation
  end

  def follow? story
    stories.include? story
  end

  private

  def downcase_email
    email.downcase!
  end
end
