class Gen
  def self.bulk(n = 1000)
    n.times do
      name = Faker::Name.name

      User.create!(
        name: name,
        email: Faker::Internet.email(name: name),
        dob: Faker::Date.between(from: 45.years.ago, to: 15.years.ago),
        gender: Faker::Gender.short_binary_type,
        title: Faker::Name.prefix,
        password: Faker::Internet.password,
      )
    end
  end
end
