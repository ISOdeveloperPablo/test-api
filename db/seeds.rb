# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# PoBox.destroy_all
# User.destroy_all
canada = PoBox.create!(box_number: 4325435, city: "Bobtown", country: "Canada", id:99)
kenya = PoBox.create!(box_number: 7568758, city: "Nairobi", country: "Kenya")
s_africa = PoBox.create!(box_number: 5869456, city: "Johannesburg", country: "South Africa")

User.create(email: "admin@hotmail.com", password: "password", first_name: "Test",  last_name: "User", phone_number: ENV["TEST_PHONE_NUMBER"], role: "Admin" , po_box_id: 99, country_code: ENV["TEST_COUNTRY_CODE"])
User.create(email: "employee@hotmail.com", password: "password", first_name: "employee",  last_name: "employee", phone_number: ENV["TEST_PHONE_NUMBER"], role: "Employee" , po_box_id: 99, country_code: ENV["TEST_COUNTRY_CODE"])
User.create(email: "recipient@hotmail.com", password: "password", first_name: "Test",  last_name: "User", phone_number: ENV["TEST_PHONE_NUMBER"], po_box_id: 99, country_code: ENV["TEST_COUNTRY_CODE"])

3.times {
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password(8), po_box: canada, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone_number: ENV["TEST_PHONE_NUMBER"] , country_code: ENV["TEST_COUNTRY_CODE"])
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password(8), po_box: kenya, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone_number: ENV["TEST_PHONE_NUMBER"] , country_code: ENV["TEST_COUNTRY_CODE"])
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password(8), po_box: s_africa, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone_number: ENV["TEST_PHONE_NUMBER"] , country_code: ENV["TEST_COUNTRY_CODE"])
}
