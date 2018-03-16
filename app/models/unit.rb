class Unit < ApplicationRecord
  belongs_to :property

  validates_presence_of :number
  validates :monthly_rent, numericality: { greater_than_or_equal_to: 0 }
  validates :bedroom_count, numericality: { greater_than_or_equal_to: 0 }
  validates :bathroom_count, numericality: { greater_than_or_equal_to: 0 }
end
