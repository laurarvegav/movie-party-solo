class ServiceFacade
  attr_reader :user,
              :movie_title,
              :movie_id

  def initialize(user, movie = false)
    @user = user

    if movie =!nil && movie.class == String
      @movie_title = movie
    elsif movie =!nil && movie.class == Integer
      @movie_id = movie
    end
  end

  def movies
    service = MovieService.new

    if @movie_title != nil
      json = service.find_movie_by_name(@movie_title)
    elsif @movie_id != nil
      json = service.find_movie_by_id(@movie_id)
    else
      json = service.top_movies
    end
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end