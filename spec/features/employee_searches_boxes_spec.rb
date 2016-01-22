require 'rails_helper'

feature 'employee views po box index page', %Q{
  as an employee
  I want to be able to see all po boxes
  so that I can select whichever one I am at now
} do
  before(:each) do
    user = FactoryGirl.create(:user, role: "Employee")
    FactoryGirl.create(:po_box, box_number: 2222, city: "Boston")
    FactoryGirl.create(:po_box, box_number: 4565, country: "Brazil")
    FactoryGirl.create(:po_box, box_number: 3333, city: "Boston")
    login(user)
  end

  scenario 'employee searches po boxes by number' do
    visit po_boxes_path
    fill_in "search", with: 2222
    click_button "Search"
    expect(page).to have_content(2222)
    expect(page).to_not have_content(3333)
    expect(page).to_not have_content(4565)
  end

  scenario 'employee searches po boxes by city' do
    visit po_boxes_path
    fill_in "search", with: "Boston"
    click_button "Search"
    expect(page).to have_content(2222)
    expect(page).to have_content(3333)
  end

  scenario 'employee searches po boxes by country' do
    visit po_boxes_path
    fill_in "search", with: "Brazil"
    click_button "Search"
    expect(page).to have_content(4565)
    expect(page).to_not have_content(2222)
    expect(page).to_not have_content(3333)
  end

end
