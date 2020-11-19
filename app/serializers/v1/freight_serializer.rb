module V1
  class FreightSerializer < ActiveModel::Serializer
    attributes :origin, :destination, :cubic_meters_total, :weight_total

    def origin
      object.origin.coordinates
    end

    def destination
      object.destination.coordinates
    end

    has_many :items, serializer: FreightItemSerializer
  end
end
