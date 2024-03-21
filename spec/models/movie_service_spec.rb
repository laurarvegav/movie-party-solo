require 'rails_helper'

RSpec.describe MovieService do
  describe 'Instance Methods' do
    it "gets URL, populating API records into JSON", :vcr do
      url = "https://api.themoviedb.org/3/discover/movie"

      parsed_movie = MovieService.new.get_url("top", url)

      expect(parsed_movie[:results].first).to be_a(Hash)
      expect(parsed_movie[:results].first[:title]).to be_a(String)
      expect(parsed_movie[:results].first[:vote_average]).to be_a(Float)

      parsed_movie = MovieService.new.get_url("name", url)

      expect(parsed_movie[:results].first).to be_a(Hash)
      expect(parsed_movie[:results].first[:title]).to be_a(String)
      expect(parsed_movie[:results].first[:vote_average]).to be_a(Float)
    end

    it "returns the top 20 movies", :vcr do
      parsed_movie = MovieService.new.top_movies

      expect(parsed_movie[:results].first).to be_a(Hash)
      expect(parsed_movie[:results].length).to eq(20)
    end

    it "finds an array of movies by keyword name", :vcr do
      keyword = "kung"
      parsed_movie = MovieService.new.find_movie_by_name(keyword)

      expect(parsed_movie[:results].length).to be_between(1, 20)
      expect(parsed_movie[:results]).to be_an(Array)
    end

    it "finds an array of movies by id", :vcr do
      id = 1011985
      parsed_movie = MovieService.new.find_movie_by_id(id)
      expect(parsed_movie).to be_a(Hash)
      expect(parsed_movie[:original_title]).not_to eq(nil)
    end
  end
end