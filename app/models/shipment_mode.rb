class ShipmentMode < ApplicationRecord
  has_paper_trail

  validates :name, :cube_factor, presence: true
  validates :cube_factor, numericality: { greater_than: 0 }
end
