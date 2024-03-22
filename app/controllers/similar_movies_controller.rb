class SimilarMoviesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @movie = ServiceFacade.new(@user, params[:movie_id].to_i).movies
    @movies = ServiceFacade.new(@user, params[:movie_id].to_i).find_similar_movies
  end
end