class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    facade = ServiceFacade.new(@user, params[:movie_id].to_i)
    @facade_movie = facade.movies
    @guests = User.all.except(@user)

    if session[:user_id].nil?
      flash[:error] = "User must be logged in or registered to create a Viewing Party"
       redirect_to user_movie_path(@user,params[:movie_id])
    end
  end

  def create
    user = User.find(params[:user_id])
    movie = ServiceFacade.new(user, params[:movie_id].to_i).movies

    if params[:party_duration].to_i < movie.raw_runtime
      redirect_to new_user_movie_viewing_party_path(user.id, movie.id)

      flash[:alert] = "Error: Party duration needs to cover at least the movie runtime"

    elsif params[:select_date].blank?
      redirect_to new_user_movie_viewing_party_path(user.id, movie.id), alert: "Error: Party date can't be empty"

    else
      @viewing_party = ViewingParty.new(duration: params[:party_duration], date: params[:select_date], start_time: params[:start_time], movie_id: movie.id, host_user_id: user.id)
  
      # Save the viewing party
      if @viewing_party.save
        # Associate selected guests with the viewing party
        
        selected_guests = selected_guests_ids.map { |id| User.find(id) }
        
        selected_guests.each do |guest|
          user.user_parties << UserParty.create(user: guest, viewing_party: @viewing_party)
        end
        redirect_to user_path(user), notice: 'Viewing party created successfully!'
      else
        # Handle validation errors
        flash.now[:alert] = 'Error creating viewing party'
        render :new
      end
    end
  end

  def show
    @user = User.find(params[:user_id])
    @facade = ServiceFacade.new(@user, params[:movie_id].to_i)
  end

  private
  def selected_guests_ids
    params.select { |key, value| key.start_with?('guest_') && value.include?('on') }.keys.map { |key| key.gsub('guest_', '').to_i }
  end
end
