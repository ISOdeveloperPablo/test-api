require 'rails_helper'

feature 'employee views po box show page', %Q{
  as an employee
  I want to be able to see a list of all recipients for each po box
  so that I can see them all
} do
  before(:each) do
    @box = FactoryGirl.create(:po_box)
    @other_box = FactoryGirl.create(:po_box)
    @user = FactoryGirl.create(:user, po_box: @box, role: "Employee")
    @other_user = FactoryGirl.create(:user, po_box: @other_box, first_name: "joe", last_name: "smith", phone_number: "other number")
    login(@user)
  end

  scenario 'employee views box show page' do
    visit po_box_path(@box)
    expect(page).to have_content(@user.first_name)
    expect(page).to have_content(@user.last_name)
    expect(page).to have_content(@user.phone_number)

    expect(page).to_not have_content(@other_user.first_name)
    expect(page).to_not have_content(@other_user.last_name)
    expect(page).to_not have_content(@other_user.phone_number)
  end

end
