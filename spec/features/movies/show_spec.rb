require 'rails_helper'

RSpec.describe 'Movie detail page', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @data_movie = {
      id: 1011985,
      original_title: "Kung Fu Panda 4",
      overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
      vote_average: 6.894,
      }

      @movie_kfp = Movie.new(@data_movie)
    end

    # User Story #3
    it 'shows a button to create a viewing party, another to return to the discover page and the information from that movie', :vcr do
      # As a user, When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
      visit user_movie_path(@user_tommy.id, @movie_kfp.id)
      # I should see
      # - a button to Create a Viewing Party
      expect(page).to have_button("Create Viewing Party")
      # - a button to return to the Discover Page
      expect(page).to have_button("Discover Page")

      # I should also see the following information about the movie:
      # - Movie Title
      expect(page).to have_content('Kung Fu Panda 4')
      # - Vote Average of the movie
      expect(page).to have_content("Vote: 6.95")
      # - Runtime in hours & minutes
      expect(page).to have_content("Runtime: 1hr 34min")
      # - Genre(s) associated to movie
      expect(page).to have_content("Genre: Action, Adventure, Animation, Comedy, Family") 
      # - Summary description
      expect(page).to have_content("Summary")
      expect(page).to have_content('Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.') # rubocop:disable Layout/LineLength
      # - List the first 10 cast members (characters & actress/actors)
      expect(page).to have_content("Cast")
      expect(page).to have_content(
        "Actor: Ronny Chieng, ")
      # - Count of total reviews
      expect(page).to have_content("1 Reviews")
      # - Each review's author and information
      expect(page).to have_content("Author Chris Sawin said _Kung Fu Panda 4_ isn’t the best _Kung Fu Panda_ film, or even the best of the series’ three sequels. However, as a fourth film in a franchise, it’s a ton of fun.\r \r And though it’s action isn’t quite as entertaining as its predecessors and it’s unfortunate to see Awkwafina playing yet another thief (_Jumanji: The Next Level_ says hello), for the most part, _Kung Fu Panda 4_ happily skadooshes its way to animated greatness.\r \r **Full review:** https://bit.ly/KuFuPa4") # rubocop:disable Layout/LineLength
    end
  end
end
