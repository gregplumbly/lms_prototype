class Lesson < ApplicationRecord
  belongs_to :course
  has_many :video_progresses, dependent: :destroy
  
  validates :title, :position, presence: true
  validates :position, uniqueness: { scope: :course_id }
  
  def duration_text
    return "0 min" if duration.blank?
    minutes = duration / 60
    "#{minutes} min"
  end
end
