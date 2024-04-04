class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

    flash[:error] = "User must be logged in or registered to access a user's dashboard" if session[:user_id].nil?
    
    redirect_to user_path(@user.id)
  end

  def create
  user = User.new(user_params)

    if user_params[:password] != user_params[:password_confirmation]
      flash[:error] = "Password and password confirmation do not match"
      redirect_to register_user_path
      return
    end

    if user.save
      flash[:success] = 'Successfully Created New User'
      redirect_to user_path(user)
    else
      flash[:error] = "#{error_message(user.errors)}"
      redirect_to register_user_path
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
