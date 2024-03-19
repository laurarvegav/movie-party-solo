class Movie
  validates_presence_of :name,
                        :vote,
                        :runtime,
                        :genre,
                        :id

  def initialize(data)
    @name = data["name"]
    @vote = data["vote"]
    @runtime = data["runtime"]
    @genre = data["genre"]
    @id = data["id"]
  end
end
