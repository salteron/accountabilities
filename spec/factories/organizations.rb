FactoryGirl.define do
  factory :organization do
    role :bank

    factory :bank do
      role :bank
    end

    factory :client do
      role :client
    end

    factory :agent do
      role :agent
    end
  end
end
