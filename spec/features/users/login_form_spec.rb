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
      fill_in :password, with: 'ests123'

      user = User.find_by( email: 'sam@email.com' )
      click_button 'Log in'
      # I'm taken back to the Log In page
      expect(current_path).to eq(login_path)
      #And I can see a flash message telling me that I entered incorrect credentials. 
      expect(page).to have_content('Sorry, incorrect credentials')
    end
  end
end
