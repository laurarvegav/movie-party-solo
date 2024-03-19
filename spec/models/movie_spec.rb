require 'rails_helper'

RSpec.describe Movie, type: :model do
 describe 'validations' do
  it { should validate_presence_of :name }
  it { should validate_presence_of :vote }
  it { should validate_presence_of :runtime }
  it { should validate_presence_of :genre }
 end

 describe 'relationships' do
  it { should have_many :viewing_parties }
 end

 describe 'instance methods' do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @movie_1 = Movie.create!(name: "The Princess Bride", vote: 9.9, runtime: "1hr 54min", genre: "Romance, Comedy, Adventure")
    @party = @movie_1.viewing_parties.create!(date: "2023-12-01", start_time: "07:25", duration: 175)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end
 end
end