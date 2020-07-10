class Exercise < ApplicationRecord
  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout, presence: true
  validates :workout_date, presence: true

  belongs_to :user
end
