FactoryGirl.define do
  factory :user do
    trait :administrator do
      is_administator true
    end
  end
end
