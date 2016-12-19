FactoryGirl.define do
  factory :accountability do
    factory :organization_user do
      role :organization_user
      association :parent, factory: :organization
      association :child, factory: :user
    end

    factory :bank_client do
      role :bank_client
      association :parent, factory: :bank
      association :child, factory: :client
    end

    factory :bank_agent do
      role :bank_agent
      association :parent, factory: :bank
      association :child, factory: :agent
    end

    factory :client_agent do
      role :client_agent
      association :parent, factory: :client
      association :child, factory: :agent
    end
  end
end
