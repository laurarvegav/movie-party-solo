require 'rails_helper'

RSpec.describe 'Similar movies page', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'testt123')
      
      @data_movie_kfp = {
      id: 1011985,
      original_title: "Kung Fu Panda 4",
      overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
      vote_average: 6.894
      }

      @data_movie_lwm = {
      id: 826680,
      original_title: "Follow a group of children who are evacuated to a Yorkshire village during the Second World War, where they encounter a young soldier who, like them, is far away from home.",
      vote_average: 6.820,
      poster_path: "https://media.themoviedb.org/t/p/original/dTUTDPilI2Ozi5GeoBRczidQTaZ.jpg",
      release_date: "2022-07-15"
      }

      @movie_kfp = Movie.new(@data_movie_kfp)
      @movie_lwm = SimilarMovie.new(@data_movie_lwm)
    end

    # User story 6
    it 'displays a a list of movies that are similar to the one provided by :movie_id with details and image', :vcr do
      # As a user, When I visit a Movie Details page (`/users/:user_id/movies/:movie_id`),
      visit user_movie_path(@user_tommy.id, @movie_kfp.id)
      # I see a link for "Get Similar Movies"
      # When I click that link
      click_link("Get Similar Movies")

      # I am taken to the Similar Movies page (`/users/:user_id/movies/:movie_id/similar`)
      expect(current_path).to eq(user_movie_similar_index_path(@user_tommy.id, @movie_kfp.id))
      # Where I see a list of movies that are similar to the one provided by :movie_id, 
      expect(page).to have_content("#{@movie_kfp.title}'s Similar Movies")
      # which includes the similar movies': 
      within("#movie-#{@movie_lwm.id}") do
        # - Title
        expect(page).to have_content(@movie_lwm.title)
        # - Overview
        expect(page).to have_content(@movie_lwm.summary)
        # - Release Date
        expect(page).to have_content(@movie_lwm.release_date)
        # - Poster image
        # - Vote Average
        expect(page).to have_content(@movie_lwm.vote)
      end
    end
  end
end