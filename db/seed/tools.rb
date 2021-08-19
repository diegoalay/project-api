def create_user(email = Faker::Internet.email, username = Faker::Internet.username)
  User.create(
    mobile_phone: Faker::PhoneNumber.phone_number,
    gender: ["male", "female"][rand(2)],
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    status: Faker::Boolean.boolean,
    username: username,
    email: email
  )
end