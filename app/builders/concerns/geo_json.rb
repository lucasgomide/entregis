module Concerns
  module GeoJson
    extend ActiveSupport::Concern
    included do
      include Dry::Monads::Try::Mixin
      include Dry::Monads[:result]

      # By decoding an Array (called coordinates) to RGeo::GeoJSON object.
      # The first argument must be one of the following
      # geometry types: Point, LineString, Polygon, MultiPoint,
      # MultiLineString, and MultiPolygon.
      # The second one is the array with coordinates
      def decode_coordinates(type, coordinates)
        Try(RGeo::Error::InvalidGeometry) do
          RGeo::GeoJSON.decode({ type: type, coordinates: coordinates }.to_json)
        end
      end

      # A helper method to convert value (array with 2 elements) to RGeo::GeoJSON::Point
      def generate_point(value)
        decode_coordinates('Point', value)
      end

      # A helper method to convert value (must be a array) to RGeo::GeoJSON::Point
      def generate_multi_polygon(value)
        decode_coordinates('MultiPolygon', value)
      end
    end
  end
end
