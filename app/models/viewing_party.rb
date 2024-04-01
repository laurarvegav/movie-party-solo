class ViewingParty < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties


  validates :start_time, presence: true
  validates :date, presence: true
  validates :duration, presence: true
  validates :movie_id, presence: true
  validates :host_user_id, presence: true

  def host
    User.find(host_user_id)
  end

  def party_movie
    return unless movie_id

    facade = ServiceFacade.new(user: host, movie_id: movie_id)
    facade.movies.first
  end

  def invite_side_msg(user)
    if host == user
      "You are the host"
    else
      "You are invited"
    end
  end
end