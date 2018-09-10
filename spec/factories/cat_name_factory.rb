FactoryBot.define do
  factory :cat_name do
    sequence(:name) { |n| "name#{n}" }
  end
end
