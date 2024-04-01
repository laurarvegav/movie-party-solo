class ViewingParty < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  # validate :min_duration

  validates :start_time, presence: true
  validates :date, presence: true
  validates :duration, presence: true
  validates :movie_id, presence: true
  validates :host_user_id, presence: true
  # validates :movie_duration, presence: true, numericality: true

  # def min_duration
  #   if duration.present? && duration < movie_duration
  #     errors.add(:duration, "cannot be shorter than movie runtime")
  #   end
  # end

  # def add_attributes(movie, host)
  #   @movie_id = movie.id
  #   @host = host
  # end

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