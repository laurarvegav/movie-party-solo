class ServiceFacade
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def movies
    service = MovieService.new

    if params[:movie_title]
      json = service.find_movie_by_name(params[:movie_title])
    else
      json = service.top_movies
    end

    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end