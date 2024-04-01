require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
      it { should have_many :user_parties }
      it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    it "creates a viewing party and assigns attributes beyond the records inherited from the database" do
      user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'testt123')
      user_sam = User.create!(name: 'Sam', email: 'sam@email.com', password: 'tests123')
      user_meg = User.create!(name: 'Meg', email: 'meg@turing.edu', password: 'me123')
      user_erin = User.create!(name: 'Erin', email: 'erin@turing.edu', password: 'er123')

      data_movie_kfp = {
        id: 1011985,
        original_title: "Kung Fu Panda 4",
        overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
        vote_average: 6.894,
        poster_path: "/dTUTDPilI2Ozi5GeoBRczidQTaZ.jpg"
      }

      movie_kfp = Movie.new(data_movie_kfp)
      viewing_party = ViewingParty.new
      viewing_party.movie = movie_kfp
      viewing_party.date = "2023-12-01"
      viewing_party.start_time = "07:25"
      viewing_party.duration = 175
      viewing_party.host = user_tommy
      viewing_party.invited = [user_sam, user_meg, user_erin]
  
      expect(viewing_party.date).to eq("2023-12-01")
      expect(viewing_party.start_time).to eq("07:25")
      expect(viewing_party.duration).to eq(175)
      expect(viewing_party.movie).to eq(movie_kfp)
      expect(viewing_party.host).to eq(user_tommy)
      expect(viewing_party.invited).to eq([user_sam, user_meg, user_erin])
    end
  end
end