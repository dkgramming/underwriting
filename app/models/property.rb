require 'normalic'

class Property < ApplicationRecord
  before_save :normalize_address

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
  has_many :quotes, dependent: :destroy

  validates :address, presence: true

  EXPENSES.each do |expense|
    validates expense, numericality: { greater_than_or_equal_to: 0 }
  end

  validates :cap_rate, numericality: true

  # Total Annual Rent Collected = Sum of rents per unit multiplied by 12
  def total_annual_rent_collected
    units.map { |unit| unit.is_vacant ? 0 : unit.monthly_rent }.reduce(:+) * 12
  end

  # Net Operating Income (NOI) = Total Annual Rent Collected - Expenses
  def net_operating_income
    total_annual_rent_collected - total_annual_expenses
  end

  private
    def normalize_address
      self.address = Normalic::Address.parse(address).to_s
    end

    def total_annual_expenses
      EXPENSES.map { |expense| self[expense] }.reduce(:+)
    end
end
