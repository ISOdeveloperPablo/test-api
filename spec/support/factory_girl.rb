require 'factory_girl'

FactoryGirl.define do

  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    first_name 'Bob'
    last_name 'Boberson'
    phone_number "1234567890"
    country_code "+254"
    association :po_box
    role 'Recipient'
  end

  factory :po_box do
    box_number "8888"
    city 'Nairobi'
    country 'Kenya'
  end

end
