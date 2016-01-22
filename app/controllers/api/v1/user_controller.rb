class API::V1::UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.jsonp { render :jsonp => @users }
    end
  end
end
