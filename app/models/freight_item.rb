class FreightItem < ApplicationRecord
  has_paper_trail

  belongs_to :freight

  validates :cubic_meters, :weight, presence: true
  validates :weight, :cubic_meters,
            numericality: { greater_than: 0 }
end
