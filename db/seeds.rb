# Creating shipment modes

[
 { name: 'Rodoviário', cube_factor: 300 },
 { name: 'Marítimo', cube_factor: 1000 },
 { name: 'Aéreo', cube_factor: 166.7 },
].map { |modes| ShipmentMode.find_or_create_by!(modes) }


# Creating vehicles

shipment_mode = ShipmentMode.find_by(name: 'Rodoviário')

[
  { name: 'Carreta Baú', cubic_meters_capacity: 90000, payload_capacity: 29000 },
  { name: 'Caminhão Caçamba', cubic_meters_capacity: 11500, payload_capacity: 13000 },
  { name: 'Fiat Fiorino', cubic_meters_capacity: 1836, payload_capacity: 600 },
].map { |vehicle| shipment_mode.vehicles.find_or_create_by!(vehicle) }

# Creating shipping carriers
shipping_carrier = ShippingCarrier.find_or_create_by!(name: 'Rapi10', document: '123456')

# Creating carriers
vehicle = Vehicle.first

current_location = RGeo::GeoJSON.decode({
  type: 'Point',
  coordinates: [
    -46.669921875,
    -23.57666015625
  ]
}.to_json).to_s

coverage_area = RGeo::GeoJSON.decode({
  type: 'MultiPolygon',
  coordinates: [
    [
      [
        [
          -51.3720703125,
          -24.510498046875
        ],
        [
          -48.592529296875,
          -25.191650390625
        ],
        [
          -49.207763671875,
          -26.69677734375
        ],
        [
          -51.998291015625,
          -25.982666015625
        ],
        [
          -51.3720703125,
          -24.510498046875
        ]
      ]
    ]
  ]
}.to_json).to_s


shipping_carrier.carriers.available.create!(
  km_price_cents: 30,
  weight_price_cents: 400,
  current_location: current_location,
  coverage_area: coverage_area,
  vehicle: vehicle
)
