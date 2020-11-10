FactoryBot.define do
  factory :freight do
    origin do
      [
        -44.384765625,
        -18.56689453125
      ]
    end
    destination do
      [
        -44.384765625,
        -18.56689453125
      ]
    end
    cubic_meters_total { 90 }
    weight_total { 1000 }

    after(:build) do |freight|
      freight.origin = RgeoJsonHelpers.coordiantes_to_wkt(freight.origin)
      freight.destination = RgeoJsonHelpers.coordiantes_to_wkt(freight.destination)
    end
  end
end
