require 'rails_helper'

RSpec.describe 'Movies Results Page', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user_sam = User.create!(name: 'Sam', email: 'sam@email.com')
    end

    # User Story #2
    it 'shows movie title as link to Movie Details Page, voters average and button to the Discover Page', :vcr do
      # When I visit the discover movies page ('/users/:id/discover'),
      visit user_discover_index_path(@user_tommy.id)
      # and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
      click_button("Discover Top Rated Movies")
      # I should be taken to the movies results page (`users/:user_id/movies`) where I see:
      expect(current_path).to eq(user_movies_path(@user_tommy.id))

      # - Title (As a Link to the Movie Details page (see story #3))
      expect(page).to have_link("Damsel")
      # - Vote Average of the movie
      expect(page).to have_content("Damsel Vote average: 7.19")

      # I should also see a button to return to the Discover Page.
      click_button("Discover Page")
      expect(current_path).to eq(user_discover_index_path(@user_tommy.id))
      
      fill_in(:movie_title, with: "Kung")
      click_button("Find Movies")
      expect(current_path).to eq(user_movies_path(@user_tommy.id))
      expect(page).to have_content("Kung Fu Panda 4 Vote average: 6.9")

      expect(page).to have_button("Discover Page")
    end
  end
end
