module V1
  class CarrierSerializer < ActiveModel::Serializer
    attributes :current_location, :coverage_area, :status, :km_price, :weight_price

    def current_location
      object.current_location.coordinates
    end

    def coverage_area
      object.coverage_area.coordinates
    end
  end
end
