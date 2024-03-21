class ServiceFacade
  attr_reader :user
              :movie_title

  def initialize(user, movie_title=nil)
    @user = user
    @movie_title = movie_title
  end

  def movies
    service = MovieService.new

    if @movie_title != nil
      json = service.find_movie_by_name(@movie_title)
    else
      json = service.top_movies
    end
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end