require 'rails_helper'

feature 'admin activates/inactivate a user, %Q{
  as an admin
  I want to be able  activates/inactivate a user
}' do
  before(:each) do
    @admin = FactoryGirl.create(:user, role: "Admin")
    @po_box = FactoryGirl.create(:po_box)
    @user2 = FactoryGirl.create(
      :user,
      first_name: "Peter",
      country_code: ENV["TEST_COUNTRY_CODE"],
      phone_number: ENV["TEST_PHONE_NUMBER"] )
  end

  scenario 'admin activates and inactivates recipient' do
    login(@admin)
    visit authenticated_root_path
    expect(page).to have_content(@user2.first_name)

    find_button("Activate").click
    expect(page).to have_content("User updated")
    find_button("Activated").click

    expect(page).to have_content("User updated")
    find_button("Activate")
  end

  # scenario 'other users cannot activate or deactivate each other' do
  #   visit new_user_session_path
  #
  #   fill_in 'Email', with: @user2.email
  #   fill_in 'Password', with: @user2.password
  #
  #   click_button 'Log in'
  #
  #   expect(page).to have_content('Signed in successfully')
  #   visit root_path
  #   expect(page).to_not have_content("Bob")
  # end

end
