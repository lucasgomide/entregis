# Creating shipment modes
puts 'Creating shipment modes'

[
 { name: 'Rodoviário', cube_factor: 300 },
 { name: 'Marítimo', cube_factor: 1000 },
 { name: 'Aéreo', cube_factor: 166.7 },
].map { |modes| ShipmentMode.find_or_create_by!(modes) }


# Creating vehicles
puts 'Creating vehicles'

shipment_mode = ShipmentMode.find_by(name: 'Rodoviário')

[
  { name: 'Carreta Baú', cubic_meters_capacity: 90000, payload_capacity: 29000 },
  { name: 'Caminhão Caçamba', cubic_meters_capacity: 11500, payload_capacity: 13000 },
  { name: 'Fiat Fiorino', cubic_meters_capacity: 1836, payload_capacity: 600 },
].map { |vehicle| shipment_mode.vehicles.find_or_create_by!(vehicle) }

# Creating shipping carriers
puts 'Creating shipping carriers'

shipping_carrier = ShippingCarrier.find_or_create_by!(name: 'Rapi10', document: '123456')

# Creating carriers
puts 'Creating carriers'

vehicle = Vehicle.first

carriers = [{
  available_payload: vehicle.payload_capacity,
  available_cubic_meters: vehicle.cubic_meters_capacity,
  km_price_cents: 30,
  weight_price_cents: 400,
  current_location: RGeo::GeoJSON.decode({
    type: 'Point',
    coordinates: [
      -44.154052734375,
      -18.318025732001438
    ]
  }.to_json),
  coverage_area: RGeo::GeoJSON.decode({
    type: 'MultiPolygon',
    coordinates: [[[
      [-44.358673095703125, -18.418381607361148],
      [-44.560546875, -18.4704914579668],
      [-44.361419677734375, -18.59939520219874],
      [-44.023590087890625, -18.340187242207897],
      [-44.2364501953125, -18.241090255870276],
      [-44.358673095703125, -18.418381607361148]
    ]]]
  }.to_json),
  vehicle: vehicle
}, {
  available_payload: vehicle.payload_capacity,
  available_cubic_meters: vehicle.cubic_meters_capacity,
  km_price_cents: 1000,
  weight_price_cents: 800,
  current_location: RGeo::GeoJSON.decode({
    type: 'Point',
    coordinates: [
      -44.37103271484374,
      -18.534304453676853
    ]
  }.to_json),
  coverage_area: RGeo::GeoJSON.decode({
    type: 'MultiPolygon',
    coordinates: [[[
      [-44.358673095703125, -18.418381607361148],
      [-44.560546875, -18.4704914579668],
      [-44.361419677734375, -18.59939520219874],
      [-44.023590087890625, -18.340187242207897],
      [-44.2364501953125, -18.241090255870276],
      [-44.358673095703125, -18.418381607361148]
    ]]]
  }.to_json),
  vehicle: vehicle
}, {
  available_payload: vehicle.payload_capacity,
  available_cubic_meters: vehicle.cubic_meters_capacity,
  km_price_cents: 1000,
  weight_price_cents: 800,
  current_location: RGeo::GeoJSON.decode({
    type: 'Point',
    coordinates: [
      -44.86473083496094,
      -18.126928351410527
    ]
  }.to_json),
  coverage_area: RGeo::GeoJSON.decode({
    type: 'MultiPolygon',
    coordinates: [[[
      [-45.0933837890625,-17.978733095556155],
      [-45.1318359375,-18.20848019603987],
      [-45.010986328125,-18.140631722312715],
      [-44.95880126953125,-18.22413378742241],
      [-44.8187255859375,-18.117139572348528],
      [-45.06317138671875,-17.936928637549432],
      [-45.0933837890625,-17.978733095556155]
    ]]]
  }.to_json),
  vehicle: vehicle
}, {
  available_payload: vehicle.payload_capacity,
  available_cubic_meters: vehicle.cubic_meters_capacity,
  km_price_cents: 1000,
  weight_price_cents: 800,
  current_location: RGeo::GeoJSON.decode({
    type: 'Point',
    coordinates:  [
      -45.0604248046875,
      -17.95391289081594
    ]
  }.to_json),
  coverage_area: RGeo::GeoJSON.decode({
    type: 'MultiPolygon',
    coordinates: [[[
      [-44.33326721191406,-18.305640122258644],
      [-44.344940185546875,-18.391669187688752],
      [-44.25464630126953,-18.420661743842945],
      [-44.247779846191406,-18.306292018544276],
      [-44.33326721191406,-18.305640122258644]
    ]]]
  }.to_json),
  vehicle: vehicle
}]

shipping_carrier.carriers.available.create!(carriers)

# Creating freight
puts 'Creating freight'

freight = Freight.create!(
  origin: RGeo::GeoJSON.decode({
    type: 'Point',
    coordinates:  [-44.327774047851555, -18.34279429196909]
  }.to_json),
  destination: RGeo::GeoJSON.decode({
    type: 'Point',
    coordinates:  [-44.2790, -18.4014]
  }.to_json),
  cubic_meters_total: 10.1,
  weight_total: 10.2,
)

freight.items.create!([{
  cubic_meters: 10.1,
  weight: 10.2
}])
