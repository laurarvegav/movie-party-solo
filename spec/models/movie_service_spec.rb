require 'rails_helper'

RSpec.describe MovieService do
  describe 'Instance Methods' do
    it "gets URL, populating API records into JSON" do
      url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc"

      parsed_movie = MovieService.new.get_url(url)

      expect(parsed_movie.first).to be_a(Hash)
      expect(parsed_movie.first["name"]).to be_a(String)
      expect(parsed_movie.first["vote"]).to be_a(Float)
      expect(parsed_movie.first["runtime"]).to be_a(String)
      expect(parsed_movie.first["genre"]).to be_a(String)
    end
  end
end