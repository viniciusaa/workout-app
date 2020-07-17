class Exercise < ApplicationRecord
  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout, presence: true, length: { minimum: 3, maximum: 200 }

  belongs_to :user

  default_scope {
    where("created_at > ?", 7.days.ago)
    .order(created_at: :desc)
  }
end
