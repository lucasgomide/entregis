class Customer < ApplicationRecord
  validates :name, :document, presence: true

  validates_length_of :document, maximum: 14
end
