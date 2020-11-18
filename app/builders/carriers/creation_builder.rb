module Carriers
  class CreationBuilder
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:build_attributes)
    include ::Concerns::Builder[Hash]

    def build_attributes
      if attributes[:current_location]
        attributes[:current_location] = yield update_current_location
      end
      if attributes[:coverage_area]
        attributes[:coverage_area] = yield update_coverate_area
      end
      super
    end

    private

    def decode_coordinates(type, coordinates)
      Try[RGeo::Error::InvalidGeometry] do
        RGeo::GeoJSON.decode({ type: type, coordinates: coordinates }.to_json)
      end
    end

    def update_current_location
      decode_coordinates(
        'Point', attributes[:current_location]
      )
    end

    def update_coverate_area
      decode_coordinates(
        'MultiPolygon', attributes[:coverage_area]
      )
    end
  end
end
