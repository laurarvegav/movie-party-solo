class MovieService
  def top_movies
    get_url("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc").take(20)
  end

  def get_url(url)
    response = mov.get(url)
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def mov
    Faraday.new(url: "https://api.themoviedb.org/3/discover/movie") do |faraday|
      faraday.headers["api_key"] = "Bearer #{Rails.application.credentials.movies_api_key}"
    end
  end
end