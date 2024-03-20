require 'rails_helper'

RSpec.describe MovieService do
  describe 'Instance Methods' do
    it "gets URL, populating API records into JSON", :vcr do
      url = "https://api.themoviedb.org/3/discover/movie"

      parsed_movie = MovieService.new.get_url(url)

      expect(parsed_movie[:results].first).to be_a(Hash)
      expect(parsed_movie[:results].first[:title]).to be_a(String)
      expect(parsed_movie[:results].first[:vote_average]).to be_a(Float)
    end

    it "returns the top 20 movies", :vcr do
      parsed_movie_results = MovieService.new.top_movies

      expect(parsed_movie_results.first).to be_a(Hash)
      expect(parsed_movie_results.length).to eq(20)
    end

    it "finds a movie by keyword name", :vcr do
      keyword = "kung"
      parsed_movie = MovieService.new.find_movie_by_name(keyword)
      
      expect(parsed_movie.first).to be_a(Hash)
      expect(parsed_movie.length).to be_between(1, 20)
      expect(parsed_movie).to eq([{:id=>284723, :name=>"kung fu okulu"},
      {:id=>780, :name=>"kung fu"},
      {:id=>14934, :name=>"shaolin kung fu"},
      {:id=>250944, :name=>"kung foo"},
      {:id=>185466, :name=>"kung fu master"},
      {:id=>301323, :name=>"animal kung fu"}])
    end
  end
end