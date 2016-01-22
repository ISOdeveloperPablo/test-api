class PoBoxesController < ApplicationController
  before_action :visitor!


  def index
    if current_user.role == "Admin" || current_user.role == "Employee"
      if params[:search]
        search = params[:search]
        @po_boxes = PoBox.search(search)
      else
        @po_boxes = PoBox.all
      end
    else
      flash[:notice] = "You do not have the rights to view this page."
      redirect_to authenticated_root_path
    end
  end

  def show
    if current_user.role == "Admin" || current_user.role == "Employee"
      @po_box = PoBox.find(params[:id])
    else
      flash[:notice] = "You do not have the rights to view this page."
      redirect_to authenticated_root_path
    end
  end

  def new
    if current_user.role == "Admin" || current_user.role == "Employee"
      @po_box = PoBox.new
    else
      flash[:notice] = "You do not have the rights to view this page."
      redirect_to authenticated_root_path
    end
  end

  def create
    @po_box = PoBox.new(po_box_params)
    if @po_box.save
      redirect_to po_boxes_path
    else
      redirect_to authenticated_root_path
    end
  end

  private

  def po_box_params
    params.require(:po_box).permit(:box_number, :city, :country)
  end
end
