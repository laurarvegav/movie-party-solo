class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    facade = ServiceFacade.new(@user, params[:movie_id].to_i)
    @facade_movie = facade.movies
    @guests = User.all.except(@user)
  end

  def create
    user = User.find(params[:user_id])
    movie = ServiceFacade.new(user, params[:movie_id].to_i).movies

    if params[:party_duration].to_i < movie.raw_runtime
      redirect_to new_user_movie_viewing_party_path(user.id, movie.id)

      flash[:alert] = "Error: Party duration needs to cover at least the movie runtime"

    elsif params[:select_date] == ""
      redirect_to new_user_movie_viewing_party_path(user.id, movie.id)

      flash[:alert] = "Error: Party date can't be empty"

    else
      @viewing_party = ViewingParty.create!(duration: params[:party_duration], date: params[:select_date], start_time: params[:start_time])

      redirect_to user_movie_viewing_party_path(user_id: params[:user_id], movie_id: params[:movie_id], id: @viewing_party.id)
    end
  end

  def show
    @user = User.find(params[:user_id])
    @facade = ServiceFacade.new(@user, params[:movie_id].to_i)
  end
end
