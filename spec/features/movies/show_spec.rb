require 'rails_helper'

RSpec.describe 'Movie detail page', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com')
    end

    it 'shows a button to create a viewing party, another to return to the discover page and the information from that movie' do
      # As a user, When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
      visit user_movie_path(@user_tommy.id, movie.id)
      # I should see
      # - a button to Create a Viewing Party
      expect(page).to have_button("Create a Viewing Party")
      # - a button to return to the Discover Page
      expect(page).to have_button("Discover Page")

      # I should also see the following information about the movie:
      # - Movie Title
      expect(page).to have_content("Damsel")
      # - Vote Average of the movie
      expect(page).to have_content("Vote: 9.9")
      # - Runtime in hours & minutes
      expect(page).to have_content("Runtime: 1hr 54min")
      # - Genre(s) associated to movie
      expect(page).to have_content("Genre: m")
      # - Summary description
      expect(page).to have_content("Summary/nx")
      # - List the first 10 cast members (characters & actress/actors)
      expect(page).to have_content("Cast/x")
      # - Count of total reviews
      expect(page).to have_content("num Reviews")
      # - Each review's author and information
      expect(page).to have_content("Author: Y Said: W")
    end
  end
end
