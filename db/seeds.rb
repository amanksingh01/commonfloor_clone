User.create!(name:  "Aman Kumar Singh",
             email: "amanksingh01@gmail.com",
             mobile_number: 9876543210,
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.unique.name
  email = "example-#{n+1}@example.com"
  mobile_number = "9876543#{n+101}"
  password = "password"
  User.create!(name:  name,
               email: email,
               mobile_number: mobile_number,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end