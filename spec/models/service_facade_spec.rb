require 'rails_helper'

RSpec.describe ServiceFacade do
  before do
    @user_sam = User.create!(name: 'Sam', email: 'sam@email.com')
    @facade = ServiceFacade.new(@user_sam)
    @facade_movie = ServiceFacade.new(@user_sam, "Kung Fu Panda 4")
    @facade_movie = ServiceFacade.new(@user_sam, 1011985)
  end

  it 'exists' do
    expect(@facade).to be_a(ServiceFacade)
  end

  it 'returns movie objects', :vcr do
    expect(@facade.movies).to be_an(Array)
    expect(@facade_movie.movies).to be_an(Array)
    expect(@facade.movies.all? {|movie| movie.class == Movie}).to eq(true)
    expect(@facade_movie.movies.all? {|movie| movie.class == Movie}).to eq(true)
    expect(@facade_movie.movies.first.id).to eq(1011985)
  end
end