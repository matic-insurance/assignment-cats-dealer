FactoryBot.define do
  factory :cats_store do
    sequence(:image) { |n| "https://olxua-ring02.akamaized.net/images_slandocomua/476948786_#{n}_1000x700_abissenysh-chempion-fotografii.jpg" }
    sequence(:location) { |n| "location#{n}" }
    sequence(:name) { |n| "name#{n}" }
    sequence(:price) { |n| "10#{n}" }
  end
end
