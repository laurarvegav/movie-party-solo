class UserParty < ApplicationRecord
  validates_presence_of :user, :viewing_party
  
  belongs_to :viewing_party
  belongs_to :user

  def invite_side
    host? ? "Hosting" : "Invited"
  end
end
