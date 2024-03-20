require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    data = {original_title: "Kung Fu Panda", vote_average: "7.9"}
    movie_kfp = Movie.new(data)

    expect(movie_kfp).to be_a(Movie)
  end
end