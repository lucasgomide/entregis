FactoryBot.define do
  factory :vehicle do
    name { 'Truck' }
    cubic_meters_capacity { 30 }
    payload_capacity { 1000 }
    shipment_mode { create(:shipment_mode) }
  end
end
