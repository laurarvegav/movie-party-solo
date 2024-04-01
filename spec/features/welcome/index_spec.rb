require 'rails_helper'

RSpec.describe 'Root Page, Welcome Index', type: :feature do
   describe 'When a user visits the root path "/"' do
      before(:each) do
         @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'testt123')
         
         visit root_path
      end

      it 'They see title of application, and link back to home page' do
         expect(page).to have_content('Viewing Party')
         expect(page).to have_link('Home')
      end

      it 'They see button to create a New User' do
         expect(page).to have_selector(:link_or_button, 'Create New User')
      end

      it "They see a list of existing users, which links to the individual user's dashboard" do
         within("#existing_users") do 
            expect(page).to have_content(User.first.email)
            expect(page).to have_content(User.last.email)
            expect(page).to have_link("#{User.first.email}", href: "users/#{User.first.id}")
            expect(page).to have_link("#{User.last.email}", href: "users/#{User.last.id}")
         end   
      end

      it "They see a link to go back to the landing page (present at the top of all pages)" do
         expect(page).to have_link("Home")
      end

      # User Story #3 - Logging In Happy Path
      it "They see a link to Log In to go to the login page" do
         expect(page).to have_link("Log In")
         #I'm taken to a Log In page ('/login') where I can input my unique email and password.
         click_link 'Log In'
         expect(current_path).to eq(login_path)
      end
   end
end
