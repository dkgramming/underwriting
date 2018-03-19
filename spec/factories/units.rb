def nearest_point_five(num)
  (num * 2).round / 2.0
end

FactoryBot.define do
  factory :unit do
    number { Faker::Number.unique.number.to_s + Faker::Types.character }
    monthly_rent { Faker::Number.normal(3350, 200) }
    is_vacant { Faker::Boolean.boolean(0.038) }
    bedroom_count { nearest_point_five(Faker::Number.between(0.0, 4.0)) }
    bathroom_count { nearest_point_five(Faker::Number.between(0.0, 2.0)) }
    property
  end
end
