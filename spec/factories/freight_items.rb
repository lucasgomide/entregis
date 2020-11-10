FactoryBot.define do
  factory :freight_item do
    cubic_meters { 30 }
    freight { create(:freight) }
    weight { 1000 }
  end
end
