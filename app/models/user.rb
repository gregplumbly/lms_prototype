class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  
  # LMS relationships
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :video_progresses, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, if: -> { password.present? }
  
  def enrolled_in?(course)
    enrollments.exists?(course: course)
  end
end
