class Exercise < ApplicationRecord
  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout, presence: true, length: { minimum: 3, maximum: 200 }
  before_save :capitalize_workout

  belongs_to :user

  default_scope {
    where("created_at > ?", 7.days.ago)
    .order(created_at: :desc)
  }

  def self.search(search)
    if !search.blank?
      where("workout like ?", "%#{search.capitalize!}%")
    end
  end

  def capitalize_workout
    self.workout.capitalize!
  end
end
