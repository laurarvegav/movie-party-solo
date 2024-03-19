require 'rails_helper'

RSpec.describe 'movies discover', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user_sam = User.create!(name: 'Sam', email: 'sam@email.com')

      visit register_user_path
    end

    # User Story #1
    it 'displays button to top rated movies, text field to search by movie title and a seach button' do
      # When I visit the '/users/:id/discover' path (where :id is the id of a valid user),
      visit user_discover_index_path(@user_tommy.id)
      # I should see
      # - a Button to Discover Top Rated Movies
      expect(page).to have_button('Find Top Rated Movies')
      # - a text field to enter keyword(s) to search by movie title
      expect(page).to have_field(:movie_title)
      # - a Button to Search by Movie Title
      expect(page).to have_button('Find Movies')
    end
  end
end