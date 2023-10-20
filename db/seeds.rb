require 'faker'

Faker::Config.locale = 'fr'

experts = []

10.times do
  name = Faker::Name.name
  expert = Expert.create(
    name:,
    email: Faker::Internet.email(name:),
    password: 'password'
  )
  experts << expert
end

1_000.times do
  wine = Wine.create(
    name: Faker::Wine.label,
    properties: Faker::Wine.accolade,
    price: Faker::Number.between(from: 10, to: 10_000),
    marketplace: Faker::Wine.brand(real: true),
    wine_type: Faker::Wine.wine_type
  )

  10.times do
    rating = Faker::Number.between(from: 0, to: 5)

    Review.create(
      wine_id: wine.id,
      expert_id: experts.pluck(:id).sample,
      rating:,
      message: Faker::Wine.accolade(bad: Faker::Boolean.boolean(true_ratio: 0.2))
    )

    Price.create(
      wine_id: wine.id,
      price: Faker::Number.between(from: 2, to: 15_000),
      date: Faker::Date.between(from: 10.years.ago.to_s, to: Date.today)
    )
  end
end
