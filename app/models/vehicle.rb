class Vehicle < ApplicationRecord
  has_paper_trail

  belongs_to :shipment_mode

  validates :name, :cubic_meters_capacity, :payload_capacity, presence: true
  validates :cubic_meters_capacity, :payload_capacity,
            numericality: { only_integer: true, greater_than: 0 }
end
