class Movie
  attr_reader :name,
              :vote,
              :runtime,
              :genre,
              :id,
              :summary

  def initialize(data)
    @name = data["original_title"]
    @vote = data["vote_average"]
    @runtime = data["runtime"]
    @genre = data["genre"]
    @id = data["id"]
    @summary = data["overview"]
  end
end
