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

  it 'returns movie cast data in array of hashes', :vcr do
    expect(@facade_movie_id.movie_cast).to eq([
      { name: "Jack Black", character: "Po (voice)" },
      { name: "Awkwafina", character: "Zhen (voice)" },
      { name: "Bryan Cranston", character: "Li (voice)" },
      { name: "Viola Davis", character: "The Chameleon (voice)" },
      { name: "Dustin Hoffman", character: "Shifu (voice)" },
      { name: "James Hong", character: "Mr. Ping (voice)" },
      { name: "Ian McShane", character: "Tai Lung (voice)" },
      { name: "Ke Huy Quan", character: "Han (voice)" },
      { name: "Ronny Chieng", character: "Fish (voice)" },
      { name: "Lori Tan Chinn", character: "Granny Boar (voice)" }
    ])
  end

  it 'returns movie review data in array of hashes', :vcr do
    expect(@facade_movie_id.movie_review).to eq([
      { author: "Chris Sawin",
        content: "_Kung Fu Panda 4_ isn’t the best _Kung Fu Panda_ film, or even the best of the series’ three sequels. However, as a fourth film in a franchise, it’s a ton of fun.\r\n\r\nAnd though it’s action isn’t quite as entertaining as its predecessors and it’s unfortunate to see Awkwafina playing yet another thief (_Jumanji: The Next Level_ says hello), for the most part, _Kung Fu Panda 4_ happily skadooshes its way to animated greatness.\r\n\r\n**Full review:** https://bit.ly/KuFuPa4"
      }
    ])
  end

  it 'returns movie providers data in hash of hashes', :vcr do
    expect(@facade_movie_id.find_movie_providers).to eq(
      { buy: { "Cineplex" => "https://media.themoviedb.org/t/p/original/d1mUAhpJpxy0YMjwVOZ4lxAAbeT.jpg" },
        rent: {}
      }
    )
  end

  it "returns an array of similar movies given base movie's id", :vcr do
    expect(@facade_movie_id.find_similar_movies).to be_an(Array)
    expect(@facade_movie_id.find_similar_movies.all? {|movie| movie.class == Movie}).to eq(true)
    expect(@facade_movie_id.find_similar_movies.first.id).to eq(14813)
  end
end