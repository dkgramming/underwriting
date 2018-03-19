FactoryBot.define do
  factory :quote do
    association :property, factory: :property_with_units
  end
end
