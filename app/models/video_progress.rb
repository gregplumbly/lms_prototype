class VideoProgress < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  
  validates :user_id, uniqueness: { scope: :lesson_id }
  validates :current_time, :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  def progress_percentage
    return 0 if duration.zero?
    ((current_time.to_f / duration) * 100).round(2)
  end
  
  def completed?
    completed == true
  end
end
