class MovieService
  def top_movies
    get_url("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc").take(20)[1][1]
  end

  def get_url(url)
    response = mov.get(url)
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def mov
    Faraday.new(url: "https://api.themoviedb.org/3/dicover/movie") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmbd[:key]
    end
  end

  def find_movie_by_name(string)
    get_url("https://api.themoviedb.org/3/search/keyword?query=#{string}").take(20)[1][1]
  end
end