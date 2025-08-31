class Course < ApplicationRecord
  has_many :lessons, -> { order(:position) }, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  
  validates :title, :slug, presence: true
  validates :slug, uniqueness: true
  
  scope :published, -> { where(published: true) }
  
  def to_param
    slug
  end
end
