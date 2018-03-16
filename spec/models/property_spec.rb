require 'rails_helper'

RSpec.describe Property, type: :model do
  it { should have_many(:units).dependent(:destroy) }

  it { should validate_presence_of(:address) }

  it do 
    should validate_numericality_of(:marketing_expense).
      is_greater_than_or_equal_to(0)
  end
  
  it do 
    should validate_numericality_of(:tax_expense).
      is_greater_than_or_equal_to(0)
  end

  it do 
    should validate_numericality_of(:insurance_expense).
      is_greater_than_or_equal_to(0)
  end

  it do 
    should validate_numericality_of(:repair_expense).
      is_greater_than_or_equal_to(0)
  end

  it do 
    should validate_numericality_of(:administration_expense).
      is_greater_than_or_equal_to(0)
  end

  it do 
    should validate_numericality_of(:payroll_expense).
      is_greater_than_or_equal_to(0)
  end

  it do 
    should validate_numericality_of(:utility_expense).
      is_greater_than_or_equal_to(0)
  end

  it do 
    should validate_numericality_of(:management_expense).
      is_greater_than_or_equal_to(0)
  end

  it { should validate_presence_of(:cap_rate) }
end
