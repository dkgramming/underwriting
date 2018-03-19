FactoryBot.define do
  factory :property do
    address do
      [
        Faker::Address.street_address,
        Faker::Address.city,
        Faker::Address.state,
        Faker::Address.zip_code
      ].join(', ')
    end
    marketing_expense { Faker::Number.between(0, 50000) }
    tax_expense { Faker::Number.between(0, 50000) }
    insurance_expense { Faker::Number.between(0, 50000) }
    repair_expense { Faker::Number.between(0, 50000) }
    admin_expense { Faker::Number.between(0, 50000) }
    payroll_expense { Faker::Number.between(0, 50000) }
    management_expense { Faker::Number.between(0, 50000) }
    cap_rate { Faker::Number.normal(0.05, 0.005) }

    factory :property_with_units do
      transient do
        units_count 12
      end

      after(:create) do |property, evaluator|
        create_list(:unit, evaluator.units_count, property: property)
      end
    end
  end
end
