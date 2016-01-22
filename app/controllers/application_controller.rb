class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # skip_before_filter :verify_authenticity_token

  before_filter :configure_permitted_parameters, if: :devise_controller?


  protected


  def visitor!
    if current_user.nil?
      redirect_to new_user_session_path
    end
  end


  def after_sign_in_path_for(user)
    if current_user.role != "Recipient"
      authenticated_root_path
    else
      user_path(current_user)
    end
  end



  def after_sign_up_path_for(user)
    if current_user.role != "Recipient"
      authenticated_root_path
    else
      user_path(current_user)
    end
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end



  def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) << [
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :country_code,
      :po_box_id
  ]

  devise_parameter_sanitizer.for(:account_update) << [
    :first_name,
    :last_name,
    :email,
    :phone_number,
    :country_code,
    :po_box_id
  ]
  end
end
