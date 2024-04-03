class User < ApplicationRecord
   validates_presence_of :name, :email
   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

   validates_presence_of :password_digest
   has_secure_password

   enum role: ["default", "manager", "admin"]

   has_many :user_parties
   has_many :viewing_parties, through: :user_parties
end
