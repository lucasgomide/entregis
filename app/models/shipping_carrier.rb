class ShippingCarrier < ApplicationRecord
  validates :name, :document, presence: true

  # Allow to cascade delete carriers association.
  # In the future, the carriers can not be deleted if any
  # shipment has associeted.
  has_many :carriers, dependent: :destroy

  validates :document, uniqueness: true
end
