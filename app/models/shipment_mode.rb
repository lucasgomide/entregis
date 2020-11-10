class ShipmentMode < ApplicationRecord
  validates :name, :cube_factor, presence: true
  validates :cube_factor, numericality: { only_integer: true, greater_than: 0 }
end
