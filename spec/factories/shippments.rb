FactoryBot.define do
  factory :shippment do
    company { create(:company) }
    freight { create(:freight) }
    carrier { create(:carrier) }
    price_cents { 1000 }
    status { 'in_progress' }
    message { nil }
  end
end
