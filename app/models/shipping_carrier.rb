class ShippingCarrier < ApplicationRecord
  validates :name, :document, presence: true
end
