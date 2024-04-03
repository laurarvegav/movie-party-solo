require 'rails_helper'

RSpec.describe UserParty, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :viewing_party }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :viewing_party }
  end

  before do
    @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'testt123')
    @user_erin = User.create!(name: 'Erin', email: 'erin@turing.edu', password: 'testt123')

    @movie_kfp = Movie.new( id: 823464,
      original_title: "Godzilla x Kong: The New Empire",
      overview: "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
      vote_average: 7.09,
      poster_path: "/gmGK5Gw5CIGMPhOmTO0bNA9Q66c.jpg"
    )

    @user_party_t = ViewingParty.new(
      movie_id: @movie_kfp.id,
      date: "2023-12-01",
      start_time: "07:25",
      duration: 175,
      host_user_id: @user_tommy.id
    )
    
    #@user_erin.user_parties << @user_party_t
  end

  describe '#invite_side' do
    it 'returns "Hosting" for host user parties' do
      expect(@user_party_t.invite_side).to eq("Hosting")
    end

    it 'returns "Invited" for invited user parties' do
      #expect(@user_erin.user_parties.first.invite_side).to eq("Invited")
    end
  end
end