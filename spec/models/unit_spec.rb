require 'rails_helper'

RSpec.describe Unit, type: :model do
  it { should belong_to(:property) }
  it { should validate_presence_of(:number) }
  it { should have_db_index([:number, :property_id]).unique(:true) }

  it do
    should validate_numericality_of(:monthly_rent).
      is_greater_than_or_equal_to(0)
  end

  it do
    should validate_numericality_of(:bedroom_count).
      is_greater_than_or_equal_to(0)
  end

  it do
    should validate_numericality_of(:bathroom_count).
      is_greater_than_or_equal_to(0)
  end
end
