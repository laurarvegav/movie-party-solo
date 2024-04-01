require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
      it { should have_many :user_parties }
      it { should have_many(:users).through(:user_parties) }
  end

  before do
    @user_tommy = User.create!(name: 'Tommy', email: 'tm@email.com', password: 'testt123')
    @user_sam = User.create!(name: 'Sam', email: 'sm@email.com', password: 'tests123')
    @user_meg = User.create!(name: 'Meg', email: 'mg@turing.edu', password: 'me123')
    @user_erin = User.create!(name: 'Erin', email: 'er@turing.edu', password: 'er123')
  end

  describe "instance methods" do
    let(:movie_kfp) do
      Movie.new(
        id: 823464,
        original_title: "Godzilla x Kong: The New Empire",
        overview: "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
        vote_average: 7.09,
        poster_path: "/gmGK5Gw5CIGMPhOmTO0bNA9Q66c.jpg"
      )
    end

    let(:viewing_party) do
      ViewingParty.new(
        movie_id: movie_kfp.id,
        date: "2023-12-01",
        start_time: "07:25",
        duration: 175,
        host_user_id: @user_tommy.id
      )
    end

    it "creates a viewing party with assigned attributes" do
      expect(viewing_party.date).to eq("2023-12-01")
      expect(viewing_party.start_time).to eq("07:25")
      expect(viewing_party.duration).to eq(175)
      expect(viewing_party.movie_id).to eq(movie_kfp.id)
      expect(viewing_party.host).to eq(@user_tommy)
    end

    it "party_movie returns a movie object when given a movie_id", :vcr do
      expect(viewing_party.party_movie).to be_a(Movie)
    end
  end
end