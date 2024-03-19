class ViewingParty < ApplicationRecord
   has_many :user_parties
   has_many :users, through: :user_parties
   belongs_to :movie

   def find_host
      users.where("user_parties.host = true").first
   end
end
