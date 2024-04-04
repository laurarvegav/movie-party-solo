require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  describe 'As an admin user' do
    before(:each) do
      @user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'testt123')
      @user_sam = User.create!(name: 'Sam', email: 'sam@email.com', password: 'tests123')
      @user_admin = User.create!(name: 'Admin', email: 'admin@email.com', password: '123', role: 2)
    end

    it 'displays all users email addresses as links to their user dashboard' do
      # When I log in as an admin user
      visit login_path
      fill_in :email, with: 'admin@email.com'
      fill_in :location, with: 'xw'
      fill_in :password, with: '123'
      click_button 'Log in'
      # I'm taken to my admin dashboard `/admin/dashboard`
      expect(current_path).to eq(admin_dashboard_path)
      # I see a list of all default user's email addresses
      within("#existing_users") do 
        User.all. each do |user|
          expect(page).to have_content(user.email)
          expect(page).to have_link("#{user.email}", href: admin_user_path(user.id))
        end
      end

      # When I click on a default user's email address
      click_link(@user_tommy.email)
      # I'm taken to the admin users dashboard. `/admin/users/:id`
      expect(current_path).to eq(admin_user_path(@user_tommy))
      # Where I see the same dashboard that particular user would see
    end
  end
end