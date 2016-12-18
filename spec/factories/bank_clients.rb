FactoryGirl.define do
  factory :bank_client do
    association :parent, factory: :bank
    association :child, factory: :client
  end
end
