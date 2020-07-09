FactoryBot.define do
  factory :exercise do
    duration_in_min { 1 }
    workout { "MyText" }
    workout_date { "2020-07-09" }
    user { nil }
  end
end
