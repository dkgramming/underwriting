require 'rails_helper'

RSpec.describe Property, type: :model do
  it { should have_many(:units).dependent(:destroy) }
  it { should have_many(:quotes).dependent(:destroy) }
  it { should validate_presence_of(:address) }

  it 'normalizes the address before saving' do
    property = Property.create!(address: '152 west 57th street new york ny 10019', cap_rate: 13.2)
    expect(property.address).to eq('152 W 57th St., New York, NY 10019')
  end

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
    should validate_numericality_of(:admin_expense).
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

  it { should validate_numericality_of(:cap_rate) }
end
