FactoryBot.define do
  factory :shipping_carrier do
    name { 'Douglas Adams' }
    sequence(:document) { |n| "#{n}x" }

    trait :with_carriers do
      after(:create) do |shipping_carrier|
        create_list(:carrier, 3, shipping_carrier: shipping_carrier)
      end
    end
  end
end
