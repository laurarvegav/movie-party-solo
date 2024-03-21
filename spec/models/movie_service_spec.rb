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

    it "finds movie credits with movie id", :vcr do
      id = 1011985
      parsed_credits = MovieService.new.find_movie_credits(id)

      expect(parsed_credits).to be_a(Hash)
      expect(parsed_credits[:cast]).to be_an(Array)
    end

    it "finds movie reviews with movie id", :vcr do
      id = 1011985
      parsed_reviews = MovieService.new.find_movie_reviews(id)

      expect(parsed_reviews).to be_a(Hash)
      expect(parsed_reviews[:results]).to be_an(Array)
    end
  end
end