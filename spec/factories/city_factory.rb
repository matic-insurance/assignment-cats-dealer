FactoryBot.define do
  factory :city do
    sequence(:location) { |n| "location#{n}" }
  end
end
