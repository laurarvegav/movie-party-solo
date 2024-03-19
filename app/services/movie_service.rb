class MovieService
  def top_movies
    movies = get_url("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc")
    filtered_holidays = parse_and_filter_holidays(holidays)
    sorted_holidays = sort_holidays_by_date(filtered_holidays).take(3)
  end

  def get_url(url)
    response = mov.get(url)
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def mov
    Faraday.new(url: "https://api.themoviedb.org/3/discover/movie") do |faraday|
      faraday.headers["api_key"] = Rails.application.credentials.movies_api_key
    end
  end
end