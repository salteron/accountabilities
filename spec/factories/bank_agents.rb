FactoryGirl.define do
  factory :bank_agent do
    association :parent, factory: :bank
    association :child, factory: :agent
  end
end
