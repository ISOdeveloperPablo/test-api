require 'rails_helper'

feature 'user registers', %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   password, and password confirmation
  # * If I don't specify the required information, I am presented with
  #   an error message
  before (:each) do
    po_box = FactoryGirl.create(:po_box, box_number: "1000")
    po_box2 = FactoryGirl.create(:po_box, box_number: "2000")
  end

  scenario 'provide valid registration information' do
    visit new_user_registration_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Re-enter Password', with: 'password'
    fill_in 'First Name', with: 'Bob'
    fill_in 'Last Name', with: 'Boberson'
    fill_in 'Phone Number', with: "1234567890"
    fill_in 'Country code', with: "+254"

    select("1000", from: "user[po_box_id]")

    # fill_in 'First Name', with: user.first_name
    # fill_in 'Last Name', with: user.last_name
    # fill_in 'Phone Number', with: user.phone_number

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end
end
