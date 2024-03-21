class Movie
  attr_reader :title,
              :vote,
              :runtime,
              :genre,
              :id,
              :summary

  def initialize(data)
    @id = data[:id]
    @title = data[:original_title]
    @vote = data[:vote_average].round(2)
    @summary = data[:overview]
    @runtime = format_runtime(data[:runtime])
    @genre = format_genre(data[:genres])
  end

  def format_runtime(data)
    hours = data / 60
    minutes = data % 60
  
    formatted_runtime = ""
    formatted_runtime += "#{hours}hr " if hours > 0
    formatted_runtime += "#{minutes}min" if minutes > 0
  
    formatted_runtime.strip
  end

  def format_genre(data)
    data.map do |genre|
      genre[:name]
    end.join(", ")
  end

  def cast(data)
    cast = {}
    data.each do |member|
      cast[member[:character]] = member[:name]
    end
    cast
  end

  def reviews(data)
    reviews = {}
    data.map do |review|
      reviews[review[:author]] = review[:content]
    end
    reviews
  end
end
