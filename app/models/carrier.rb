class Carrier < ApplicationRecord
  has_paper_trail

  belongs_to :shipping_carrier
  belongs_to :vehicle

  monetize :km_price_cents
  monetize :weight_price_cents

  enum status: {
    available: 'available',
    busy: 'busy'
  }

  validates :current_location, :status, :km_price_cents,
            :weight_price_cents, presence: true

  validates :available_payload, :available_cubic_meters,
            numericality: { greater_than_or_equal_to: 0 }

  validate :exceeded_available_payload, if: -> { available_payload && vehicle }
  validate :exceeded_available_cubic_meters, if: -> { available_cubic_meters && vehicle }

  # An error should be added into model errors if the available_payload
  # attribute is greater than the payload capacity of its vehicle
  def exceeded_available_payload
    return if available_payload <= vehicle.payload_capacity

    errors.add(:available_payload, :exceeded_limit)
  end

  # An error should be added into model errors if the available_cubic_meters
  # attribute is greater than the cubic meters capacity of its vehicle
  def exceeded_available_cubic_meters
    return if available_cubic_meters <= vehicle.cubic_meters_capacity

    errors.add(:available_cubic_meters, :exceeded_limit)
  end
end
