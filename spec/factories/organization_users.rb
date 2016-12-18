FactoryGirl.define do
  factory :organization_user do
    association :parent, factory: :bank
    association :child, factory: :user
  end
end
