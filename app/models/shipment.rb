class Shipment < ApplicationRecord
  has_paper_trail

  belongs_to :customer
  belongs_to :freight
  belongs_to :carrier

  monetize :price_cents, numericality: {
    greater_than_or_equal_to: 0
  }

  enum status: {
    in_progress: 'in_progress',
    delivered: 'delivered',
    refused: 'refused'
  }

  validates :price_cents, :status, presence: true
end
