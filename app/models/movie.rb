class Movie < ApplicationRecord
  validates_presence_of :name,
                        :vote,
                        :runtime,
                        :genre
   
  has_many :viewing_parties
end
