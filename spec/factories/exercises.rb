FactoryBot.define do
  factory :exercise do
    duration_in_min { FFaker::Random.rand(1..200) }
    workout { FFaker::Name.name }
    workout_date { "2020-07-09" }
  end
end
