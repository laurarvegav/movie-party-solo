require 'rails_helper'

RSpec.describe 'Viewing Partys Show Page', type: :feature do
 describe 'As a user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'testt123')
      @user_sam = User.create!(name: 'Sam', email: 'sam@email.com', password: 'tests123')
      @user_meg = User.create!(name: 'Meg', email: 'meg@turing.edu', password: 'me123')
      @user_erin = User.create!(name: 'Erin', email: 'erin@turing.edu', password: 'er123')

      @data_movie = {
        id: 1011985,
        original_title: "Kung Fu Panda 4",
        overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
        vote_average: 6.894,
        runtime: 94
      }
      @movie_kfp = Movie.new(@data_movie)
      @viewing_party = ViewingParty.create!(duration: "100", date: "04/01/2024", start_time: "7:00", host_user_id: @user_tommy.id, movie_id: @movie_kfp.id)
    end

    # User story #5
    it 'displays video providers photos and information avaiable', :vcr do
      # As a user, When I visit a Viewing Party's show page (`/users/:user_id/movies/:movie_id/viewing_party/:id`),
      visit user_movie_viewing_party_path(@user_tommy.id, @movie_kfp.id, @viewing_party.id)
      # I should see 
      # - logos of video providers for where to buy the movie (e.g. Apple TV, Vudu, etc.)
      expect(page).to have_content("Buy the movie here:")
      expect(page).to have_content("Cineplex")
      # - logos of video providers for where to rent the movie (e.g. Amazon Video, DIRECTV, etc.)
      expect(page).to have_content("Rent the movie here:")
      # And I should see a data attribution for the JustWatch platform that reads: 
      expect(page).to have_content("Buy/Rent data provided by JustWatch")
      # as per TMDB's instructions.
    end
 end
end
