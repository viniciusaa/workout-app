class Exercise < ApplicationRecord
  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout, presence: true, length: { minimum: 3, maximum: 20 }
  validates :workout_date, presence: true

  belongs_to :user
end
