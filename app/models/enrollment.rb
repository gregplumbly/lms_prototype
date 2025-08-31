class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  
  validates :user_id, uniqueness: { scope: :course_id }
  
  def completed?
    completed_at.present?
  end
  
  def in_progress?
    enrolled_at.present? && completed_at.blank?
  end
end
