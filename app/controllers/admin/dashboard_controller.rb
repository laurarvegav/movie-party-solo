class Admin::DashboardController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    flash[:error] = "User must be logged in or registered to access a user's dashboard" if session[:user_id].nil?
  end
end