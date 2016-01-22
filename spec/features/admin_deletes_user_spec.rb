require 'rails_helper'

feature 'admin deletes user', %Q{
  as an admin
  I want to be able to
  delete users
} do

  before(:each) do
    admin = FactoryGirl.create(:user, role: "Admin")
    @user = FactoryGirl.create(:user, first_name: "Marcos")
    po_box = FactoryGirl.create(:po_box, box_number: "1000")
    login(admin)
  end

  scenario 'admin deletes a user' do
    visit authenticated_root_path

    expect(page).to have_content(@user.first_name)

    click_button "Delete User"

    expect(page).to_not have_content(@user.first_name)
  end

end
