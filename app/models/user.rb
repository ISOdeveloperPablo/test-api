class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :po_box
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  SID = ENV['TWILIO_ACCOUNT_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  TWILIO_PHONE_NUMBER = ENV['TWILIO_PHONE_NUMBER']

  DEFAULT_MESSAGE = [
  "Welcome to EAGLE MESSENGER! Where notifications are sent promptly via SMS on arrival of your letters at the Post Office.",
  "Hi, Your EAGLE MESSENGER account has been deactivated. Please contact the administrator to reactivate.",
  "You got a letter in your Postal BOX #{Time.now.strftime("%B %d, %Y %a")}"
]
  def clean_numbers(str_numbers)
    str_numbers.gsub(/[^0-9]/, '')
  end

  def full_phone_number
     "+#{clean_numbers(country_code)}#{clean_numbers(phone_number)}"
  end

  def send_welcome_message
    welcome_message = DEFAULT_MESSAGE[0]
    send_message(full_phone_number, welcome_message)
  end

  def send_mail_message
    mail_message = DEFAULT_MESSAGE[2]
    send_message(full_phone_number, mail_message)
  end

  def good_bye_message
    good_bye_message = DEFAULT_MESSAGE[1]
    send_message(full_phone_number, good_bye_message)
  end

  def good_welcome_trigger
    if is_activated == true
      send_welcome_message
    else
      good_bye_message
    end
  end


  def send_message(recipient_phone, body)
   twilio_number = ENV["TWILIO_PHONE_NUMBER"]
   client = Twilio::REST::Client.new( SID, AUTH_TOKEN)
   client.account.messages.create(
     from: TWILIO_PHONE_NUMBER,
     to: recipient_phone,
     body: body
   )
 end
end
