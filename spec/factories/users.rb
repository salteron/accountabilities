FactoryGirl.define do
  factory :user do
    role :user

    trait :administrator do
      role :administrator
    end
  end
end
