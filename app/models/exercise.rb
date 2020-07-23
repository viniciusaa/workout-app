class Exercise < ApplicationRecord
  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout, presence: true, length: { minimum: 3, maximum: 200 }
  before_save :downcase_workout

  belongs_to :user

  default_scope {
    where("created_at > ?", 7.days.ago)
    .order(created_at: :desc)
  }

  def self.search(search)
    if !search.blank?
      where("workout like ?", "%#{search.downcase}%")
    end
  end

  def downcase_workout
    self.workout.downcase!
  end
end
