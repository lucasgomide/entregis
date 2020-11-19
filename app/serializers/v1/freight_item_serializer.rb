module V1
  class FreightItemSerializer < ActiveModel::Serializer
    attributes :cubic_meters, :weight
  end
end
