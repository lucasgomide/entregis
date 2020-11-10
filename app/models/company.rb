class Company < ApplicationRecord
  validates :name, :document, presence: true
end
