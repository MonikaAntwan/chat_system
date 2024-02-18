FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
  end
end

FactoryBot.define do
  factory :chat do
  end
end

FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
  end
end
