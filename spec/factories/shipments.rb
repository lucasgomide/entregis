FactoryBot.define do
  factory :shipment do
    customer { create(:customer) }
    freight { create(:freight) }
    carrier { create(:carrier) }
    price_cents { 1000 }
    status { 'in_progress' }
    message { nil }
  end
end
