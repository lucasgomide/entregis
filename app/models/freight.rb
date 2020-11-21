class Freight < ApplicationRecord
  has_paper_trail

  validates :origin, :destination, :cubic_meters_total, :weight_total, presence: true
  validates :cubic_meters_total, :weight_total,
            numericality: { greater_than: 0 }

  has_many :items, class_name: 'FreightItem', dependent: :destroy
end
