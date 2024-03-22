class ViewingParty < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  attr_accessor :movie, 
                :date, 
                :start_time, 
                :duration, 
                :host, 
                :invited

  def add_attributes(movie, host)
    @movie = movie
    @host = host
  end

  def add_guests(array)
    @invited = array
  end
end