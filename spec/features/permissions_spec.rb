require 'rails_helper'

feature 'Users permissions %Q{
  The app should be protected from different users.
}' do

  let!(:admin) { FactoryGirl.create(:user, role: "Admin") }
  let!(:employee) { FactoryGirl.create(:user, role: "Employee") }
  let!(:recipient) { FactoryGirl.create(:user, role: "Recipient") }

  scenario "A visitor should be redirected to the login page" do
    visit unauthenticated_root_path
    expect(page).to have_content("Log in")

    visit users_path
    expect(page).to have_content("Log in")

    visit authenticated_root_path
    expect(page).to have_content("Log in")

    visit po_boxes_path
    expect(page).to have_content("Log in")
  end

  scenario "After login, a recipient should be redirected to the user show page" do
    login(recipient)
    expect(page).to have_content(recipient.first_name)
  end

  scenario "After login, an admin should be redirected to the user index page" do
    login(admin)
    expect(page).to have_content(recipient.first_name)
  end

  scenario "After sign up, a recipient should be redirected to the user show page" do
    login(recipient)
    expect(page).to have_content(recipient.first_name)
  end

  scenario "After sign up, an employee should be redirected to the user index page" do
    login(employee)
    expect(page).to have_content(recipient.first_name)
  end

  scenario "After sign out, the user should be redirected to te login page" do
    login(employee)
    visit users_path
    click_link "Sign Out"
    expect(page).to have_content("Sign In")
  end

  # RECIPIENT PERMISIONS

  scenario "A recipient can only visit user show page and user edit page" do
    login(recipient)
    visit po_boxes_path
    expect(page).to_not have_content("Client Info")
    expect(page).to_not have_content("Po-Boxes")
    expect(page).to_not have_content("New Po-Box")
    expect(page).to_not have_content("Add Users")
    # expect(page).to have_content("You do not have the rights to view this page.")
  end

  # EMPLOYEE PERMISIONS
  scenario "An Employee can't add a new employee" do
    login(employee)
    expect(page).to have_content(recipient.first_name)
    expect(page).to_not have_content("Add Users")
    visit new_admin_path
    expect(page).to have_content("You do not have the rights to view this page.")
  end

  scenario "An Employee can't edit another employee" do
    employe2 = FactoryGirl.create(:user, role: "Employee", first_name: "Michele")
    login(employee)
    visit edit_admin_path(employe2)
    expect(page).to have_content("You do not have the rights to view this page.")
  end

  scenario "An Employee can't see other employees" do
    login(employee)
    visit admin_index_path
    expect(page).to have_content("You do not have the rights to view this page.")
  end

end
