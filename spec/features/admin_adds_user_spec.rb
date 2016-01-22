require 'rails_helper'

feature 'admin creates a new user', %Q{
  as an admin
  I want to be able to
  add new users
  view errors when form fails
} do

  before(:each) do
    @user = FactoryGirl.create(:user, role: "Admin")
    po_box = FactoryGirl.create(:po_box, box_number: "1000")
    login(@user)
  end

  scenario 'admin adds new user and succeeds' do

    visit new_admin_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Re-enter Password', with: 'password'
    fill_in 'First Name', with: 'Bob'
    fill_in 'Last Name', with: 'Boberson'
    fill_in 'Phone Number', with: "1234567890"
    fill_in 'Country code', with: "+254"

    select("1000", from: "user[po_box_id]")
    select("Employee", from: "user[role]")

    click_button "Add Employee"
    expect(page).to have_content("New user created")
  end

  scenario 'admin adds new user and fails' do
    visit new_admin_path

    click_button "Add Employee"
    expect(page).to have_content("Email can't be blank. Password can't be blank. First name can't be blank. Last name can't be blank. Phone number can't be blank
")
  end
end
