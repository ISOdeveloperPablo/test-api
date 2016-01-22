class AdminController < ApplicationController
   before_action :visitor!

  def new
    if current_user.role == "Admin"
      @user = User.new
      @roles = Admin::ROLES
    else
      flash[:notice] = "You do not have the rights to view this page."
      redirect_to authenticated_root_path
    end
  end

  def index
    if current_user.role == "Admin"
      @employees = User.where(role:"Employee")
    else
      flash[:notice] = "You do not have the rights to view this page."
      redirect_to authenticated_root_path
    end
  end

  def create
    @user = User.new(admin_params)
    if @user.save
      flash[:notice] = "New user created"
      redirect_to new_admin_path
    else
      flash[:alert] = @user.errors.full_messages.join(". ")
      redirect_to new_admin_path
    end
  end

  def edit
    if current_user.role == "Admin"
      @user = User.find(params[:id])
      @roles = Admin::ROLES
    else
      flash[:notice] = "You do not have the rights to view this page."
      redirect_to authenticated_root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(admin_params)
      flash[:notice] = "User edited"
      redirect_to authenticated_root_path
    else
      flash[:alert] = @user.errors.full_messages.join(". ")
      redirect_to :back
    end
  end


  def destroy
    @user = User.find(params[:id])
    if current_user.role == "Admin"
      if @user.destroy
        flash[:notice] = "User deleted"
        redirect_to authenticated_root_path
      else
        flash[:alert] = "Something went wrong"
        redirect_to :back
      end
    else
      flash[:notice] = "You do not have the rights to delete users."
      redirect_to authenticated_root_path
    end
  end

  protected
  def admin_params
    params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :phone_number,
          :country_code,
          :po_box_id,
          :password,
          :role
        )
    end
end
