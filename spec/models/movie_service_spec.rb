require 'rails_helper'

RSpec.describe MovieService do
  describe 'Instance Methods' do
    it "gets URL, populating API records into JSON", :vcr do
      url = "https://api.themoviedb.org/3/discover/movie"

      parsed_movie = MovieService.new.get_url(url)

      expect(parsed_movie.first).to be_a(Hash)
      expect(parsed_movie.first[:name]).to be_a(String)
      expect(parsed_movie.first[:vote]).to be_a(Float)
      expect(parsed_movie.first[:runtime]).to be_a(String)
      expect(parsed_movie.first[:genre]).to be_a(String)
    end

    it "returns the top 20 movies", :vcr do
      parsed_movie = MovieService.new.top_movies

      expect(parsed_movie.first).to be_a(Hash)
      expect(parsed_movie.length).to eq(20)
    end
  end
end