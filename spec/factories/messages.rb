FactoryBot.define do
  factory :message do
    body { FFaker::Lorem.sentence }
  end
end
