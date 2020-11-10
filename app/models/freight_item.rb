class FreightItem < ApplicationRecord
  belongs_to :freight

  validates :cubic_meters, :weight, presence: true
  validates :weight, :cubic_meters,
            numericality: { only_integer: true, greater_than: 0 }
end
