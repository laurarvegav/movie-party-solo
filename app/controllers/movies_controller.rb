class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    if status == 400
      redirect_to user_discover_index_path(@user.id)
      flash[:alert] =  "Error: Try a different movie title"
    else
      @facade = ServiceFacade.new(@user)
    end
  end
end