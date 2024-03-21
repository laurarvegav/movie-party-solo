require 'rails_helper'

RSpec.describe ServiceFacade do
  before do
    @user_sam = User.create!(name: 'Sam', email: 'sam@email.com')
    @facade = ServiceFacade.new(@user_sam)
    @facade_movie_title = ServiceFacade.new(@user_sam, "Kung Fu Panda 4")
    @facade_movie_id = ServiceFacade.new(@user_sam, 1011985)
  end

  it 'exists' do
    expect(@facade).to be_a(ServiceFacade)
  end

  it 'returns movie objects', :vcr do
    expect(@facade.movies).to be_an(Array)
    expect(@facade_movie_title.movies).to be_an(Array)
    expect(@facade_movie_id.movies).to be_a(Movie)
    expect(@facade.movies.all? {|movie| movie.class == Movie}).to eq(true)
    expect(@facade_movie_title.movies.all? {|movie| movie.class == Movie}).to eq(true)
    expect(@facade_movie_title.movies.first.id).to eq(1011985)
    expect(@facade_movie_id.movies.title).to eq("Kung Fu Panda 4")
  end
end