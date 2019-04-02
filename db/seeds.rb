# Users
User.create!(name:  "Aman Kumar Singh",
             email: "amanksingh01@gmail.com",
             mobile_number: 9876543210,
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             seller: true)

29.times do |n|
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

# Properties

user = User.find_by(email: "amanksingh01@gmail.com")

# Apartments

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "sell",
                                   bed_rooms:       "1bhk",
                                   area:            600,
                                   price:           1500000,
                                   street_address:  "121, dum dum road",
                                   locality:        "dum dum",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700074",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-01.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "rent",
                                   bed_rooms:       "1bhk",
                                   area:            600,
                                   price:           4000,
                                   street_address:  "122, salt lake road",
                                   locality:        "salt lake",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700064",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-02.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "sell",
                                   bed_rooms:       "2bhk",
                                   area:            1200,
                                   price:           3000000,
                                   street_address:  "123, karol bagh road",
                                   locality:        "karol bagh",
                                   city:            "new delhi",
                                   state:           "delhi",
                                   pincode:         "110005",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-03.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "rent",
                                   bed_rooms:       "2bhk",
                                   area:            1200,
                                   price:           8000,
                                   street_address:  "124, ultadanga road",
                                   locality:        "ultadanga",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700067",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-04.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "sell",
                                   bed_rooms:       "3bhk",
                                   area:            1800,
                                   price:           4500000,
                                   street_address:  "125, dwarka road",
                                   locality:        "dwarka",
                                   city:            "new delhi",
                                   state:           "delhi",
                                   pincode:         "110075",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-05.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "rent",
                                   bed_rooms:       "3bhk",
                                   area:            1800,
                                   price:           12000,
                                   street_address:  "126, dum dum road",
                                   locality:        "dum dum",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700074",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-06.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "sell",
                                   bed_rooms:       "4bhk",
                                   area:            2400,
                                   price:           6000000,
                                   street_address:  "127, salt lake road",
                                   locality:        "salt lake",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700064",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-07.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "rent",
                                   bed_rooms:       "4bhk",
                                   area:            2400,
                                   price:           16000,
                                   street_address:  "128, lake town road",
                                   locality:        "lake town",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700089",
                                   country:         "india")
property.picture = Rails.root.join("app/assets/images/apartment-08.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "sell",
                                   bed_rooms:       "4+bhk",
                                   area:            3000,
                                   price:           7500000,
                                   street_address:  "129, ultadanga road",
                                   locality:        "ultadanga",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700067",
                                   country:         "india",
                                   sold:            true,
                                   sold_at:         Time.zone.now,
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-09.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "apartment",
                                   property_status: "rent",
                                   bed_rooms:       "4+bhk",
                                   area:            3000,
                                   price:           20000,
                                   street_address:  "130, esplanade road",
                                   locality:        "esplanade",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700013",
                                   country:         "india",
                                   sold:            true,
                                   sold_at:         Time.zone.now,
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/apartment-10.jpg").open
property.save!

# House

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "sell",
                                   bed_rooms:       "1bhk",
                                   area:            800,
                                   price:           2500000,
                                   street_address:  "131, dum dum road",
                                   locality:        "dum dum",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700074",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-01.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "rent",
                                   bed_rooms:       "1bhk",
                                   area:            800,
                                   price:           6000,
                                   street_address:  "132, salt lake road",
                                   locality:        "salt lake",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700064",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-02.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "sell",
                                   bed_rooms:       "2bhk",
                                   area:            1600,
                                   price:           5000000,
                                   street_address:  "133, lake town road",
                                   locality:        "lake town",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700089",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-03.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "rent",
                                   bed_rooms:       "2bhk",
                                   area:            1600,
                                   price:           12000,
                                   street_address:  "134, ultadanga road",
                                   locality:        "ultadanga",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700067",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-04.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "sell",
                                   bed_rooms:       "3bhk",
                                   area:            2400,
                                   price:           7500000,
                                   street_address:  "135, esplanade road",
                                   locality:        "esplanade",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700013",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-05.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "rent",
                                   bed_rooms:       "3bhk",
                                   area:            2400,
                                   price:           18000,
                                   street_address:  "136, dum dum road",
                                   locality:        "dum dum",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700074",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-06.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "sell",
                                   bed_rooms:       "4bhk",
                                   area:            3200,
                                   price:           10000000,
                                   street_address:  "137, salt lake road",
                                   locality:        "salt lake",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700064",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-07.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "rent",
                                   bed_rooms:       "4bhk",
                                   area:            3200,
                                   price:           24000,
                                   street_address:  "138, lake town road",
                                   locality:        "lake town",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700089",
                                   country:         "india")
property.picture = Rails.root.join("app/assets/images/house-08.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "sell",
                                   bed_rooms:       "4+bhk",
                                   area:            4000,
                                   price:           12500000,
                                   street_address:  "139, ultadanga road",
                                   locality:        "ultadanga",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700067",
                                   country:         "india",
                                   sold:            true,
                                   sold_at:         Time.zone.now,
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-09.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "house",
                                   property_status: "rent",
                                   bed_rooms:       "4+bhk",
                                   area:            4000,
                                   price:           30000,
                                   street_address:  "140, esplanade road",
                                   locality:        "esplanade",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700013",
                                   country:         "india",
                                   sold:            true,
                                   sold_at:         Time.zone.now,
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/house-10.jpg").open
property.save!

# Plots

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "plot",
                                   property_status: "sell",
                                   bed_rooms:       "na",
                                   area:            500,
                                   price:           1000000,
                                   street_address:  "141, dum dum road",
                                   locality:        "dum dum",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700074",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/plot-01.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "plot",
                                   property_status: "sell",
                                   bed_rooms:       "na",
                                   area:            1000,
                                   price:           2000000,
                                   street_address:  "142, salt lake road",
                                   locality:        "salt lake",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700064",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/plot-02.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "plot",
                                   property_status: "sell",
                                   bed_rooms:       "na",
                                   area:            1500,
                                   price:           3000000,
                                   street_address:  "143, lake town road",
                                   locality:        "lake town",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700089",
                                   country:         "india",
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/plot-03.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "plot",
                                   property_status: "sell",
                                   bed_rooms:       "na",
                                   area:            2000,
                                   price:           4000000,
                                   street_address:  "144, ultadanga road",
                                   locality:        "ultadanga",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700067",
                                   country:         "india")
property.picture = Rails.root.join("app/assets/images/plot-04.jpg").open
property.save!

property = user.properties.create!(owner_name:      Faker::Name.name,
                                   property_type:   "plot",
                                   property_status: "sell",
                                   bed_rooms:       "na",
                                   area:            2500,
                                   price:           5000000,
                                   street_address:  "145, esplanade road",
                                   locality:        "esplanade",
                                   city:            "kolkata",
                                   state:           "west bengal",
                                   pincode:         "700013",
                                   country:         "india",
                                   sold:            true,
                                   sold_at:         Time.zone.now,
                                   approved:        true,
                                   approved_at:     Time.zone.now,
                                   approved_by:     user)
property.picture = Rails.root.join("app/assets/images/plot-05.jpg").open
property.save!

# Property wishlists
interested_users    = User.first(26)[1..25]
favorite_properties = Property.where(approved: true).first(15)

favorite_properties.each do |property|
  interested_users.each { |user| user.add_to_favorites(property) }
end

# Property comments
users      = User.first(15)
properties = Property.where(approved: true).first(15)

users.each do |user|
  properties.each do |property|
    comment = Faker::Lorem.paragraph(2)
    user.comments.create!(property: property, comment: comment)
  end
end