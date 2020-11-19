class Vehicle < ApplicationRecord
  has_paper_trail

  belongs_to :shipment_mode
  has_many :carriers, dependent: :restrict_with_exception

  validates :name, :cubic_meters_capacity, :payload_capacity, presence: true
  validates :cubic_meters_capacity, :payload_capacity,
            numericality: { greater_than_or_equal_to: 0 }
end
