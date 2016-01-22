require 'rails_helper'

feature 'admin creates a po box', %Q{
  as an admin
  I want to be able to see all po boxes
  so that I can expand the service
} do
  let!(:user) { FactoryGirl.create(:user, role: "Admin") }

  scenario 'admin adds po box' do
    login(user)

    visit new_po_box_path
    # create an admin user first
    fill_in "Box#", with: "1234"
    fill_in "City", with: "Nairobi"
    fill_in "Country", with: "Kenya"
    click_button "Create"
    expect(page).to have_content("1234")
  end
end
