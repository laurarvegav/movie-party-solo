class MovieService
  def get_url(kind, url)
    response = connection(kind).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def connection(kind)
    uri = uri_kind(kind)
    Faraday.new(url: "https://api.themoviedb.org/3#{uri}") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmbd[:key]
    end
  end

  def top_movies
    get_url("top", "?sort_by=popularity.desc")
  end

  def find_movie_by_name(string)
    get_url("name", "?query=#{string}")
  end

  def find_movie_by_id(id)
    get_url("id", "#{id}")
  end

  def find_movie_credits(id)
    get_url("id", "#{id}/credits")
  end

  def find_movie_reviews(id)
    get_url("id", "#{id}/reviews")
  end

  def find_movie_providers(id)
    get_url("id", "#{id}/watch/providers")
  end

  def find_similar_movies(id)
    get_url("id", "#{id}/similar")
  end

  def uri_kind(kind)
    if kind == "top"
      "/discover/movie"
    elsif kind == "name"
      "/search/movie"
    elsif kind == "id"
      "/movie"
    end
  end
end