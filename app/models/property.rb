class Property < ApplicationRecord
  EXPENSES = [
    MARKETING = :marketing_expense,
    TAX = :tax_expense,
    INSURANCE = :insurance_expense,
    REPAIR = :repair_expense,
    ADMINISTRATION = :admin_expense,
    PAYROLL = :payroll_expense,
    UTILITY = :utility_expense,
    MANAGEMENT = :management_expense
  ].freeze

  has_many :units, dependent: :destroy

  validates :address, presence: true

  EXPENSES.each do |expense|
    validates expense, numericality: { greater_than_or_equal_to: 0 }
  end

  validates :cap_rate, numericality: true
end
