class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    cookies.encrypted[:location] = params[:location]
    if user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to user_path(user)
      end
    else
      flash[:error] = "Sorry, incorrect credentials"
      render :new
    end
  end

  def destroy
    session.destroy
  end
end