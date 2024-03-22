require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user_sam = User.create!(name: 'Sam', email: 'sam@email.com')
      @user_meg = User.create!(name: 'Meg', email: 'meg@turing.edu')
      @user_erin = User.create!(name: 'Erin', email: 'erin@turing.edu')

      @data_movie = {
        id: 1011985,
        original_title: "Kung Fu Panda 4",
        overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
        vote_average: 6.894,
        runtime: 94,
        poster_path: "/dTUTDPilI2Ozi5GeoBRczidQTaZ.jpg"
      }
      @movie_kfp = Movie.new(@data_movie)
      
      @viewing_party_t = ViewingParty.new
      @viewing_party_e = ViewingParty.new

      
      @viewing_party_t.movie = @movie_kfp
      @viewing_party_t.date = "2023-12-01"
      @viewing_party_t.start_time = "07:25"
      @viewing_party_t.duration = 175
      @viewing_party_t.host = @user_tommy
      @viewing_party_t.invited = [@user_sam, @user_meg, @user_erin]
      
      @viewing_party_e.movie = @movie_kfp
      @viewing_party_e.date = "2023-12-01"
      @viewing_party_e.start_time = "07:25"
      @viewing_party_e.duration = 175
      @viewing_party_e.host = @user_erin
      @viewing_party_e.invited = [@user_sam, @user_meg, @user_tommy]

      @viewing_party_t.save
      @viewing_party_e.save
      
      @user_tommy.viewing_parties << @viewing_party_t
      @user_erin.viewing_parties << @viewing_party_e
    end

    # User story #7
    it 'shows the viewing parties that the user has been invited to, and the ones the user is hosting with details', :vcr do
      # As a user, When I visit a user dashboard ('/user/:user_id'),
      visit user_path(@user_tommy.id)
      save_and_open_page
      # I should see the viewing parties that the user has been invited to with the following details:
      # - Movie Title, which links to the movie show page
      expect(page).to have_link(@viewing_party_e.movie.title)
      # - Date and Time of Event
      expect(page).to have_content("Party Time: #{@viewing_party_e.date} at #{@viewing_party_e.start_time}")
      # - who is hosting the event
      expect(page).to have_content("Hosted by: #{@user_erin}")
      # - list of users invited, with my name in bold
      expect(page).to have_content(@user_sam.name)
      expect(page).to have_content(@user_meg.name)
      expect(page).to have_content(@user_tommy.name)
      
      # I should also see the viewing parties that the user has created (hosting) with the following details:
      # - Movie Image
      # - Movie Title, which links to the movie show page
      expect(page).to have_content(@viewing_party_t.movie.title)
      # - Date and Time of Event
      expect(page).to have_content(@viewing_party_t.date)
      expect(page).to have_content(@viewing_party_t.start_time)
      # - That I am the host of the party
      expect(page).to have_content("You are the host")
      # - List of friends invited to the viewing party
      expect(page).to have_content(@user_sam.name)
      expect(page).to have_content(@user_meg.name)
      expect(page).to have_content(@user_erin.name)
    end
  end
end
