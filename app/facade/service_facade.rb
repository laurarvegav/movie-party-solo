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

  def find_movie_providers
    service = MovieService.new

    json = service.find_movie_providers(@movie_id)

    cast = { buy: {}, rent: {} }
    json[:results].each do |provider_data|
      buy_data = Array(provider_data[1][:buy])
      rent_data = Array(provider_data[1][:rent])
      buy_data.each do |buy|
        if buy.is_a?(Hash)
          cast[:buy][buy[:provider_name]] = "https://media.themoviedb.org/t/p/original#{buy[:logo_path]}" if buy.key?(:provider_name) && buy.key?(:logo_path)
        end
      end

      rent_data.each do |rent|
        if rent.is_a?(Hash)
          cast[:rent][rent[:provider_name]] = "https://media.themoviedb.org/t/p/original#{rent[:logo_path]}" if rent.key?(:provider_name) && rent.key?(:logo_path)
        end
      end
    end
    cast
  end

  def find_similar_movies
    service = MovieService.new

    json = service.find_similar_movies(@movie_id)
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
