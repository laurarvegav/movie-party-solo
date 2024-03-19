class MoviesController < ApplicationController

  def index
    user = User.find(params[:user_id])
    if params["movie_title"].empty? 
      redirect_to user_discover_index_path(user.id)
      flash[:alert] =  "Error: Try a different movie title"
    end
  end
end