class ViewingPartyController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    facade = ServiceFacade.new(@user, params[:movie_id].to_i)
    @facade_movie = facade.movies
    @guests = User.all.except(@user)
  end

  def create
    viewing_party = ViewingParty.create!(duration: params[:party_duration], date: params[:select_date], start_time: params[:start_time])

    redirect_to user_movie_viewing_party_path(user_id: params[:user_id], movie_id: params[:movie_id], id: viewing_party.id)
  end
end