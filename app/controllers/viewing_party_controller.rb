class ViewingPartyController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    facade = ServiceFacade.new(@user, params[:movie_id].to_i)
    @facade_movie = facade.movies
    @guests = User.all.except(@user)
  end

  def create

  end
end