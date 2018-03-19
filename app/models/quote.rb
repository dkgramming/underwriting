require 'faker'

class Quote < ApplicationRecord
  belongs_to :property

  # Loan amount = The lesser of:
	# •	The value
	# •	The present value of debt payments where the debt service is >= 1.25
  def loan_amount
    if present_value < value && debt_service >= 1.25
      return present_value
    else
      return value
    end
  end

  # Debt Rate = 10 year Treasury* + 200 bps
  def debt_rate
    ten_year_treasury + bps(200)
  end

  def to_h
    {
      loan_amount: loan_amount,
      debt_rate: debt_rate
    }
  end

  private
    # Random value between the 52 week range as of Friday, March 26, 2018
    def ten_year_treasury
      Faker::Number.between(0.020144, 0.029537)
    end

    # Convert Basis Points to a decimal
    def bps(basis_points)
      basis_points * 0.0001
    end

    # Debt Payment = Debt Rate * Loan Proceeds
    def debt_payment
      loan_proceeds = 0
      debt_rate * loan_proceeds
    end

    # Debt Service = NOI / Debt Payment
    def debt_service
      property.net_operating_income / debt_payment
    end

    # Value = NOI / Capitalization Rate
    def value
      property.net_operating_income / property.cap_rate
    end

    # Present Value = Payoff Amount / (1+rate)^number of payments
    def present_value
      # Payoff amount = 0, we’re assuming a fully amortizing loan
      payoff_amount = 0
    end
end
