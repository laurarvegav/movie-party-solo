require 'rails_helper'

RSpec.describe UserParty, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :viewing_party }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :viewing_party }
  end

  describe '#invite_side' do
    it 'returns "Hosting" for host user parties' do
      user_tommy = User.create!(name: 'Tommy', email: 'tommy@email.com')
      viewing_party_t = user_tommy.viewing_parties.create!(duration: "100", date: "04/01/2024", start_time: "7:00")
      user_party_t = UserParty.create!(user: user_tommy, viewing_party: viewing_party_t, host: true)
      
      expect(user_party_t.invite_side).to eq("Hosting")
    end

    it 'returns "Invited" for invited user parties' do
      user_erin = User.create!(name: 'Erin', email: 'erin@turing.edu')
      viewing_party_e = user_erin.viewing_parties.create!(duration: "100", date: "04/01/2024", start_time: "7:00")
      user_party_e = UserParty.create!(user: user_erin, viewing_party: viewing_party_e, host: false)
      
      expect(user_party_e.invite_side).to eq("Invited")
    end
  end
end