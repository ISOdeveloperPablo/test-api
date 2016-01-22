require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user, country_code:"+(303)", phone_number:"-343-433") }

  describe User do
     it { should belong_to(:po_box) }

     it { should validate_presence_of(:first_name) }
     it { should validate_presence_of(:last_name) }
     it { should validate_presence_of(:phone_number) }
   end

  describe "clean_numbers()" do
    scenario "it should return a string with only numbers" do
      str_numbers = "+(274) 454-3444"
      expect(user.clean_numbers(str_numbers)).to eq("2744543444")
    end
  end
  describe "full_phone_number" do
    scenario "It should return a real and complete phone number" do
      country_code ="+(303)"
      phone_number= "-343-433"
      expect(user.full_phone_number).to eq("+303343433")
    end
  end
  # TEST FOR TWILIO
  # describe "good_bye_message" do
  #   scenario "" do
  #
  #   end
  # end
  # describe "good_welcome_trigger" do
  #   scenario "" do
  #
  #   end
  # end
  # describe "send_welcome_message" do
  #   scenario "" do
  #
  #   end
  # end
  # describe "send_message()" do
  #   scenario "" do
  #
  #   end
  # end
end
