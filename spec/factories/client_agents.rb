FactoryGirl.define do
  factory :client_agent do
    association :parent, factory: :client
    association :child, factory: :agent
  end
end
