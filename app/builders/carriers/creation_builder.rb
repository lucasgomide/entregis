module Carriers
  class CreationBuilder
    include Dry::Monads::Do.for(:build_attributes)
    include ::Concerns::Builder[Hash]
    include ::Concerns::GeoJson

    # TODO: Refactor attributes converters. It must be easy to convert them
    # then set to the attributes.
    def build_attributes
      cur_location, cov_area = attributes.slice(:current_location, :coverage_area).values

      add(:coverage_area, (yield generate_multi_polygon(cov_area))) if cov_area
      add(:current_location, (yield generate_point(cur_location))) if cur_location

      super
    end
  end
end
