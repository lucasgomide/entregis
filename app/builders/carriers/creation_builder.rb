module Carriers
  class CreationBuilder
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:build_attributes)
    include ::Concerns::Builder[Hash]

    def build_attributes
      attributes[:current_location] = yield decode_coordinates(
        'Point', attributes[:current_location]
      ) if attributes[:current_location]

      attributes[:coverage_area] = yield decode_coordinates(
        'MultiPolygon', attributes[:coverage_area]
      ) if attributes[:coverage_area]

      super
    end

    private

    def decode_coordinates(type, coordinates)
      Try[RGeo::Error::InvalidGeometry] do
        RGeo::GeoJSON.decode({ type: type, coordinates: coordinates }.to_json)
      end
    end
  end
end
