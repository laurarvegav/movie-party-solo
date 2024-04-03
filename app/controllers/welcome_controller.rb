class WelcomeController < ApplicationController
  def index
    @users = User.all
    unless cookies[:greeting]
      cookies.encrypted[:greeting] = 'Hello there!'
    end
  end
end
