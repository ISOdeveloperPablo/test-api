require 'rails_helper'

feature 'admin edits user', %Q{
  as an admin
  I want to be able to
  edit users
  view errors when form fails
} do

  before(:each) do
    admin = FactoryGirl.create(:user, role: "Admin")
    @user = FactoryGirl.create(:user, first_name: "Marcos")
    po_box = FactoryGirl.create(:po_box, box_number: "1000")
    login(admin)
  end

  scenario 'admin edits user and succeeds' do
    visit authenticated_root_path

    click_button "Edit User"

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Re-enter Password', with: 'password'
    fill_in 'First Name', with: 'Bob'
    fill_in 'Last Name', with: 'Boberson'
    fill_in 'Phone Number', with: "1234567890"
    fill_in 'Country code', with: "+254"

    select("1000", from: "user[po_box_id]")
    select("Employee", from: "user[role]")

    click_button "Update User"
    expect(page).to have_content("User edited")
  end

  scenario 'admin edits and fails' do
    visit authenticated_root_path

    click_button "Edit User"

    click_button "Update User"

    expect(page).to have_content("Password can't be blank")
  end
end
