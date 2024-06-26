require 'rails_helper'

RSpec.describe 'Users Log In Form', type: :feature do
  describe 'As a Registered User' do
    before(:each) do
      @user = User.create!(name: 'Sam', email: 'sam@email.com', password: 'tests123')
    end

    # User Story #3 - Logging In Happy Path
    it "They can input their unique email and password and are taken to their dashboard page" do
      visit login_path 
      #When I enter my unique email and correct password 
      fill_in :email, with: 'sam@email.com'
      fill_in :location, with: 'xw'
      fill_in :password, with: 'tests123'

      user = User.find_by( email: 'sam@email.com' )
      click_button 'Log in'
      #I'm taken to my dashboard page
      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    it "when the user's credentials do not match the records, an error message is displayed and user is redirected to login path" do
      # As a registered user, When I visit the landing page `/`
      visit root_path
      # And click on the link to go to my dashboard
      click_link 'Log In'
      # And fail to fill in my correct credentials 
      fill_in :email, with: 'sam@email.com'
      fill_in :location, with: 'xw'
      fill_in :password, with: 'ests123'

      user = User.find_by( email: 'sam@email.com' )
      click_button 'Log in'
      # I'm taken back to the Log In page
      expect(current_path).to eq(login_path)
      #And I can see a flash message telling me that I entered incorrect credentials. 
      expect(page).to have_content('Sorry, incorrect credentials')
    end

    #Cookies Challenge
    it 'allows user to enter location and keeps it on the landing page on different sessions' do
      #As a user, when I go to the login page (/login)
      visit login_path
      # Under the normal login fields (username, password)
      fill_in :email, with: 'sam@email.com'
      fill_in :password, with: 'tests123'
      # I also see a text input field for "Location"
      expect(page).to have_field('Location')
      # When I enter my city and state in this field (e.g. "Denver, CO")
      # and successfully log in
      fill_in :location, with: 'Denver, CO'
      # I see my location on the landing page as I entered it.
      click_button 'Log in'
      expect(page).to have_content('Location: Denver, CO')
      click_button 'Log out'
      # Then, when I log out and return to the login page
      visit login_path
      # I still see my location that I entered previously already typed into the Location field.
      expect(page).to have_field('Location', with: 'Denver, CO')
    end
  end

  describe 'As a logged-in user' do
    before do
      @user_sam = User.create!(name: 'Sam', email: 'sam@email.com', password: 'tests123')
    end

    #Sessions Challenge
    it 'keeps a session even when user navigates to a different website', :js, :vcr do
      # As a user when I log in successfully
      visit login_path
      
      fill_in :email, with: 'sam@email.com'
      fill_in :password, with: 'tests123'
      fill_in :location, with: 'Denver, CO'
      click_button 'Log in'
      user = User.find_by( email: 'sam@email.com' )
      # and then leave the website and navigate to a different website entirely,
      # Simulating leaving the website by executing JavaScript to redirect
      page.execute_script("window.location.href = 'http://www.google.com'")
      sleep 2
      #expect(current_path).to eq("http://www.google.com")
      # Then when I return to *this* website,
      visit root_path
      # I see that I am still logged in. 
      expect(page).to have_link('Log Out')
    end

    #Log out a user
    it 'shows log out button only when a user is logged in and otherwise shows a Create an Account button' do
      # As a logged-in user 
      visit login_path
      
      fill_in :email, with: 'sam@email.com'
      fill_in :password, with: 'tests123'
      fill_in :location, with: 'Denver, CO'
      click_button 'Log in'
      user = User.find_by( email: 'sam@email.com' )
      
      # When I visit the landing page
      visit root_path
      # I no longer see a link to Log In or Create an Account
      expect(page).not_to have_link('Log In')
      expect(page).not_to have_link('Create New User')
      # But I only see a link to Log Out.
      # When I click the link to Log Out,
      click_link('Log Out')
      # I'm taken to the landing page
      expect(current_path).to eq(root_path)
      # And I see that the Log Out link has changed back to a Log In link
      expect(page).to have_link('Log In')
      # And I still see the Create an Account button.
      expect(page).to have_button('Create New User')
    end

    it 'does not show links of current users' do
      # As a logged-in user
      visit login_path
      
      fill_in :email, with: 'sam@email.com'
      fill_in :password, with: 'tests123'
      fill_in :location, with: 'Denver, CO'
      click_button 'Log in'
      user = User.find_by( email: 'sam@email.com' )
      
      # When I visit the landing page
      visit root_path
      # The list of existing users is no longer a link to their show pages
      expect(page).not_to have_link(user.email)
      # But just a list of email addresses
      expect(page).to have_content(user.email)
    end
  end

  describe "As a visitor" do
    before do
      @user_sam = User.create!(name: 'Sam', email: 'sam@email.com', password: 'tests123')
    end

    it 'does not show current users to visitors' do
      # As a visitor When I visit the landing page
      visit root_path
      # I do not see the section of the page that lists existing users
      expect(page).not_to have_content('Existing Users')
    end

    it 'only allows logged in users to visit a users dashboard' do
      # As a visitor When I visit the landing page
      visit root_path
      # And then try to visit the user's dashboard ('/users/:user_id')
      visit user_path(@user_sam.id)
      # I remain on the landing page
      expect(current_path).to eq(root_path)
      # And I see a message telling me that I must be logged in or registered to access a user's dashboard.
      expect(page).to have_content("User must be logged in or registered to access a user's dashboard")
    end

    it 'only allows logged in users to create a Viewing Party', :vcr do
      data_movie = {
        id: 1011985,
        original_title: "Kung Fu Panda 4",
        overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
        vote_average: 6.894,
        runtime: 94,
        poster_path: "/dTUTDPilI2Ozi5GeoBRczidQTaZ.jpg"
      }
      movie_kfp = Movie.new(data_movie)
      
      # As a visitor If I go to a movies show page ('/users/:user_id/movies/:movie_id')
      visit user_movie_path(user_id: @user_sam.id, id: 1011985)
      # And click the button to Create a Viewing Party
      click_button('Create Viewing Party')
      # I'm redirected back to the movies show page, and a message appears to let me know I must be logged in or registered to create a Viewing Party. 
      expect(current_path).to eq(user_movie_path(user_id: @user_sam.id, id: 1011985))
      expect(page).to have_content("User must be logged in or registered to create a Viewing Party")
    end
  end
end