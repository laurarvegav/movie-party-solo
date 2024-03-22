require 'rails_helper'

RSpec.describe SimilarMovie do
  before do
    @data_movie = {
      id: 14854,
      original_title: "Lone Wolf McQuade",
      overview: "The archetypical renegade Texas Ranger wages war against a drug kingpin with automatic weapons, his wits and martial arts after a gun battle leaves his partner dead. All of this inevitably culminates in a martial arts showdown between the drug lord and the ranger, and involving the woman they both love.",
      vote_average: 6.894,
      poster_path: "https://media.themoviedb.org/t/p/original//dTUTDPilI2Ozi5GeoBRczidQTaZ.jpg",
      release_date: "1983-04-15"
    }

    @movie_lwm = SimilarMovie.new(@data_movie)
  end

  describe ".initialize" do
    it 'exists' do
      expect(@movie_lwm).to be_a(SimilarMovie)
    end

    it 'populates attributes correctly' do

      expect(@movie_lwm.id).to eq(14854)
      expect(@movie_lwm.title).to eq('Lone Wolf McQuade')
      expect(@movie_lwm.vote).to eq(6.89)
      expect(@movie_lwm.poster_path).to eq("https://media.themoviedb.org/t/p/original//dTUTDPilI2Ozi5GeoBRczidQTaZ.jpg")
      expect(@movie_lwm.release_date).to eq("1983-04-15")
      expect(@movie_lwm.summary).to eq('The archetypical renegade Texas Ranger wages war against a drug kingpin with automatic weapons, his wits and martial arts after a gun battle leaves his partner dead. All of this inevitably culminates in a martial arts showdown between the drug lord and the ranger, and involving the woman they both love.')
    end
  end
end