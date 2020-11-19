module Carriers
  class CreationBuilder
    include Dry::Monads::Do.for(:build_attributes)
    include ::Concerns::Builder[Hash]
    include ::Concerns::GeoJson

    # It's being used on creation and updating operations of carrier. To create a
    # valid object for these operations.
    # That's the reason validate if the attribute is present before
    # set/update its value.
    # TODO: Refactor attributes converters. It must be easy to convert them
    # then set to the attributes.
    # Another refactor (in the future) is isolate the attributes set by operations.
    def build_attributes
      cur_location, cov_area, vehicle_id = attributes.slice(
        :current_location, :coverage_area, :vehicle_id
      ).values

      add(:coverage_area, (yield generate_multi_polygon(cov_area))) if cov_area
      add(:current_location, (yield generate_point(cur_location))) if cur_location
      add(:available_cubic_meters, (yield vehicle).cubic_meters_capacity) if vehicle_id
      add(:available_payload, (yield vehicle).payload_capacity) if vehicle_id

      super
    end

    private

    def vehicle
      Try(ActiveRecord::RecordNotFound) do
        @vehicle ||= Vehicle.find(attributes[:vehicle_id])
      end
    end
  end
end
