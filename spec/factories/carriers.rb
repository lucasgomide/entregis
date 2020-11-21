FactoryBot.define do
  factory :carrier, traits: [:available] do
    current_location { [-44.384765625, -18.56689453125] }
    coverage_area do
      [[[
        [-51.61376953125, -15.2490234375],
        [-39.92431640625, -15.6884765625],
        [-51.52587890625, -29.091796875],
        [-57.32666015625, -17.9296875],
        [-56.97509765625, -13.8427734375],
        [-51.61376953125, -15.2490234375]
      ]]]
    end
    shipping_carrier { create(:shipping_carrier) }
    vehicle { create(:vehicle) }
    km_price_cents { 1000 }
    weight_price_cents { 1000 }

    trait :available do
      status { 'available' }
    end

    trait :payload_full do
      available_payload { 0 }
    end

    trait :full_storage do
      available_cubic_meters { 0 }
    end

    after(:build) do |carrier|
      carrier.current_location = coordiantes_to_wkt(
        carrier.current_location
      )
      carrier.coverage_area = coordiantes_to_wkt(
        carrier.coverage_area, 'MultiPolygon'
      )
      carrier.available_cubic_meters ||= carrier.vehicle.cubic_meters_capacity
      carrier.available_payload ||= carrier.vehicle.payload_capacity
    end
  end
end
