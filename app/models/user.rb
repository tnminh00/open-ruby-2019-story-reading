class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable,
    :validatable, :lockable

  has_many :comments
  has_many :follows
  has_many :stories, through: :follows
  has_many :histories
  has_many :chapters, through: :histories
  has_many :notifications
  ratyrate_rater
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, length: {maximum: Settings.email.maximum}
  validates :password, format: {with: Settings.password_format,
    message: I18n.t("devise.registrations.new.password_format")}
  validate :password_diff_email_or_name

  USER_PARAMS = %i(name email password password_confirmation).freeze

  def follow story
    stories << story
  end

  def unfollow follow_relation
    follows.destroy follow_relation
  end

  def follow? story
    stories.include? story
  end

  def password_diff_email_or_name
    if password == name || password == email
      errors.add :password, I18n.t("devise.registrations.new.error_password")
    end
  end
end
