class Movie
  attr_reader :title,
              :vote,
              :raw_runtime,
              :genre,
              :id,
              :summary,
              :poster_path

  def initialize(data)
    @id = data[:id]
    @title = data[:original_title]
    @vote = data[:vote_average].round(2)
    @summary = data[:overview]
    @raw_runtime = data[:runtime]
    @genre = format_genre(data[:genres])
    @poster_path = "https://media.themoviedb.org/t/p/original#{data[:poster_path]}"
  end

  def runtime
    if @raw_runtime != nil
      hours = @raw_runtime / 60
      minutes = @raw_runtime % 60
    
      formatted_runtime = ""
      formatted_runtime += "#{hours}hr " if hours > 0
      formatted_runtime += "#{minutes}min" if minutes > 0
    
      formatted_runtime.strip
    end
  end

  def format_genre(data)
    if data != nil
      data.map do |genre|
        genre[:name]
      end.join(", ")
    end
  end

  def cast(data)
    cast = Hash.new("")
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
