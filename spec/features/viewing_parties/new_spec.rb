require 'rails_helper'

RSpec.describe 'New viewing party page', type: :feature do
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
        runtime: 94
        }
  
        @movie_kfp = Movie.new(@data_movie)
    end

    # User story #4
    it 'shows the name of the movie, duration of party (default to movie runtime and condition for it to be bigger than that runtime), and a form for details', :vcr do
      # When I visit the new viewing party page ('/users/:user_id/movies/:movie_id/viewing_party/new', where :user_id is a valid user's id and :movie_id is a valid Movie id from the API),
      visit new_user_movie_viewing_party_path(@user_tommy.id, @movie_kfp.id)
        #then the guests can be:
        @guests = User.all.except(@user_tommy)

      # I should see the name of the movie title rendered above a form with the following fields:
      expect(page).to have_content("Kung Fu Panda 4")
      # - Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
      expect(page).to have_field("Party Duration:")
      default = find("#party_duration").value
      expect(default).to eq("94")
      # - When: field to select date
      fill_in("date", with: "04/01/2024")
      # - Start Time: field to select time
      expect(page).to have_field("Select Time")
      # - Guests: three (optional) text fields for guest email addresses 
      expect(page).to have_content("Invite Other Users")
        # Select all guest checkboxes
        @guests.each do |guest|
          check("guest_#{guest.id}")
        end
      # - Button to create a party
      click_button("Create Party")
      expect(current_path).to eq(user_path(@user_tommy.id))

      expect(page).to have_content("Viewing party created successfully!")
    end

    #Sad Path Testing, Feature 4
    it 'responds to set duration when that is less than the movie runtime', :vcr do
      visit new_user_movie_viewing_party_path(@user_tommy.id, @movie_kfp.id)
      fill_in("party_duration", with: "60")
      fill_in("date", with: "04/01/2024")
      expect(page).to have_field("date", type: "date")
      expect(page).to have_field("Select Time")
      click_button("Create Party")

      expect(current_path).to eq(new_user_movie_viewing_party_path(@user_tommy.id, @movie_kfp.id))

      expect(page).to have_content("Error: Party duration needs to cover at least the movie runtime")
    end

    #Sad Path Testing, Feature 4
    it 'responds to empty selected date', :vcr do
      visit new_user_movie_viewing_party_path(@user_tommy.id, @movie_kfp.id)
      fill_in("party_duration", with: "94")
      fill_in("date", with: "")
      expect(page).to have_field("date", type: "date")
      expect(page).to have_field("Select Time")
      click_button("Create Party")

      expect(current_path).to eq(new_user_movie_viewing_party_path(@user_tommy.id, @movie_kfp.id))

      expect(page).to have_content("Error: Party date can't be empty")
    end
  end
end