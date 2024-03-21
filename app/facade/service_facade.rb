class ServiceFacade
  attr_reader :user,
              :movie_title,
              :movie_id

  def initialize(user, movie = nil)
    @user = user

    if movie !=nil && movie.class == String
      @movie_title = movie
    elsif movie !=nil && movie.class == Integer
      @movie_id = movie
    end
  end

  def movies
    service = MovieService.new

    if @movie_id == nil

      if @movie_title != nil
        json = service.find_movie_by_name(@movie_title)
      else
        json = service.top_movies
      end

      json[:results].map do |movie_data|
        Movie.new(movie_data)
      end

    else
      movie_data = service.find_movie_by_id(@movie_id)
      Movie.new(movie_data)
    end
  end

  def movie_cast
    service = MovieService.new

    json = service.find_movie_credits(@movie_id)

    cast = []

    10.times do |index|
      cast_data = json[:cast][index]
      cred = {
        name: cast_data[:name],
        character: cast_data[:character]
      }
      cast << cred
    end
    cast
  end

  def movie_review
    service = MovieService.new

    json = service.find_movie_reviews(@movie_id)

    cast = []
    json[:results].map do |review_data|
      cred = {
        author: review_data[:author],
        content: review_data[:content]
      }
      cast << cred
    end
    cast
  end
end