class SimilarMovie
  attr_reader :title,
              :vote,
              :poster_path,
              :release_date,
              :id,
              :summary

  def initialize(data)
    @id = data[:id]
    @title = data[:original_title]
    @vote = data[:vote_average].round(2)
    @summary = data[:overview]
    @poster_path = data[:poster_path]
    @release_date = data[:release_date]
  end
end
