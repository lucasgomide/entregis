# A helper method to generate a WKT for representing vector geometry objects.
# It's beign used on factories.

module RgeoJsonHelpers
  def coordiantes_to_wkt(coordinates, type = 'Point')
    RGeo::GeoJSON.decode({
      type: type,
      coordinates: coordinates
    }.to_json).to_s
  end
end
