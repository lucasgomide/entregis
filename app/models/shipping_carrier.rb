class ShippingCarrier < ApplicationRecord
  validates :name, :document, presence: true

  has_many :carriers
end
