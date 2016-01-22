require 'rails_helper'

feature 'employee views po box index page', %Q{
  as an employee
  I want to be able to see all po boxes
  so that I can select whichever one I am at now
} do
  before(:each) do
    user = FactoryGirl.create(:user, role: "Employee")
    FactoryGirl.create(:po_box, box_number: 2222)
    FactoryGirl.create(:po_box, box_number: 3333)
    login(user)
  end

  scenario 'employee views all po boxes' do
    visit po_boxes_path
    expect(page).to have_content(2222)
    expect(page).to have_content(3333)
  end

  scenario 'employee views po box show page' do
    visit po_boxes_path
    click_link(2222)
    expect(page).to have_content(2222)
    expect(page).to have_content("Nairobi")
    expect(page).to have_content("Kenya")
    expect(page).to_not have_content(3333)
  end

end
