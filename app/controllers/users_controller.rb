class UsersController < ApplicationController
  before_action :visitor!


  def index
    if current_user.role != "Recipient"
      @users = User.all.to_a.delete_if{|user| user.po_box == nil || user.role != "Recipient"}.sort_by { |user| [user.po_box, user.first_name, user.last_name] }
    else
      redirect_to user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user !=  @user
      flash[:alert] = "You do not have the rights to do this."
      redirect_to user_path(current_user)
    end
  end

  def activate
    @user = User.find(params[:user_id])
    if current_user.role == "Admin"

      respond_to do |f|
        f.html do
            @user.update(is_activated: params['user']['is_activated'])
            flash[:success] = "User updated"
            redirect_to authenticated_root_path
          end
          f.js do
            @user.update!(is_activated: params['user']['is_activated'])
          end
        end
          @user.good_welcome_trigger
    else
      flash[:error] = "You don't have access to do this"
      redirect_to authenticated_root_path
    end
  end

  def text_message_send
    @user = User.find(params[:user_id])
    respond_to do |f|
      f.html do
        @user.send_mail_message
        redirect_to authenticated_root_path
      end
      f.js do
        @user.send_mail_message
      end
    end
  end
end
