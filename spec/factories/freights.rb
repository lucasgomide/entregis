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
      freight.origin = coordiantes_to_wkt(freight.origin)
      freight.destination = coordiantes_to_wkt(freight.destination)
    end

    trait :with_items do
      after(:create) do |freight|
        freight.items = create_list(:freight_item, 3, freight: freight)
      end
    end
  end
end
