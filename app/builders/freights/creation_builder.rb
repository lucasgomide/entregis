module Freights
  class CreationBuilder
    include Dry::Monads::Do.for(:build_attributes)
    include ::Concerns::Builder[Hash]
    include ::Concerns::GeoJson

    # TODO: Refactor attributes converters. It must be easy to convert them
    # then set to the attributes.
    def build_attributes
      origin, destination = attributes.slice(:origin, :destination).values

      add(:origin, (yield generate_point(origin)))
      add(:destination, (yield generate_point(destination)))

      super
    end
  end
end
