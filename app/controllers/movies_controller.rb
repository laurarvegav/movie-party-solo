class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    if status == 400
      redirect_to user_discover_index_path(@user.id)
      flash[:alert] =  "Error: Try a different movie title"
    else
      @facade = ServiceFacade.new(@user, params[:movie_title])
    end
  end

  def show
    @user = User.find(params[:user_id])
    facade = ServiceFacade.new(@user, params[:id].to_i)
    @facade_movie = facade.movies
    @cast = facade.movie_cast
    @reviews = facade.movie_review
  end
end