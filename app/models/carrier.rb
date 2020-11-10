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
end
