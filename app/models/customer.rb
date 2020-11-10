class Customer < ApplicationRecord
  validates :name, :document, presence: true
end
