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
    # @runtime = data[:runtime]
    # @genre = data[:genre]
    # @id = data[:id]
    # @summary = data[:overview]
  end
end
