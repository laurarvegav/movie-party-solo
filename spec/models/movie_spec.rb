require 'rails_helper'

RSpec.describe Movie do
  before do
    @data_movie = {
      genres: [
        { id: 28, name: "Action" },
        { id: 12, name: "Adventure" },
        { id: 16, name: "Animation" },
        { id: 35, name: "Comedy" },
        {id: 10751, name: "Family" }
      ],
      id: 1011985,
      original_title: "Kung Fu Panda 4",
      overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
      vote_average: 6.894,
      runtime: 94
    }

    @data_cast = [
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
    ]

    @data_reviews = [
      {
        author: "Chris Sawin",
        content: "_Kung Fu Panda 4_ isn’t the best _Kung Fu Panda_ film, or even the best of the series’ three sequels. However, as a fourth film in a franchise, it’s a ton of fun.\r\n\r\nAnd though it’s action isn’t quite as entertaining as its predecessors and it’s unfortunate to see Awkwafina playing yet another thief (_Jumanji: The Next Level_ says hello), for the most part, _Kung Fu Panda 4_ happily skadooshes its way to animated greatness.\r\n\r\n**Full review:** https://bit.ly/KuFuPa4"
      }
    ]

    @movie_kfp = Movie.new(@data_movie)

    @incomplete_data_movie = {
      id: 1011985,
      original_title: "Kung Fu Panda 4",
      overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
      vote_average: 6.894,
    }

    @movie_inc = Movie.new(@incomplete_data_movie)
  end

  describe ".initialize" do
    it 'exists' do
      expect(@movie_kfp).to be_a(Movie)
    end

    it 'populates attributes correctly' do

      expect(@movie_kfp.id).to eq(1011985)
      expect(@movie_kfp.title).to eq('Kung Fu Panda 4')
      expect(@movie_kfp.vote).to eq(6.89)
      expect(@movie_kfp.summary).to eq('Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.')
    end

    it 'exists even when data[:runtime] and/or data[:genres] is not complete' do
      expect(@movie_inc).to be_a(Movie)
    end
  end
  
  describe 'format_runtime' do
    it 'formats runtime to format xhr xxmin' do
      expect(@movie_kfp.runtime).to eq('1hr 34min')
    end
  end

  describe 'format_genre' do
    it 'formats genre into a string and elements separated with commas' do
      expect(@movie_kfp.genre).to eq('Action, Adventure, Animation, Comedy, Family')
    end
  end

  describe 'cast' do
    it 'returns up to the first 10 cast members' do
      expect(@movie_kfp.cast(@data_cast).length).to be_between(1, 10)
    end

    it 'formats cast into a hash where the keys are characters and values are the actors names' do
      expect(@movie_kfp.cast(@data_cast)).to eq(
        {
          "Fish (voice)"=>"Ronny Chieng", 
          "Granny Boar (voice)"=>"Lori Tan Chinn", 
          "Han (voice)"=>"Ke Huy Quan",
          "Li (voice)" => "Bryan Cranston",
          "Mr. Ping (voice)" => "James Hong",
          "Po (voice)" => "Jack Black",
          "Shifu (voice)" => "Dustin Hoffman",
          "Tai Lung (voice)" => "Ian McShane", 
          "The Chameleon (voice)"=>"Viola Davis", 
          "Zhen (voice)"=>"Awkwafina"
        }
      )
    end
  end

  describe 'reviews' do
    it 'formats reviews into a hash where the keys are authors and values are the contents' do
      expect(@movie_kfp.reviews(@data_reviews)).to eq(
        {
          "Chris Sawin" =>
            "_Kung Fu Panda 4_ isn’t the best _Kung Fu Panda_ film, or even the best of the series’ three sequels. However, as a fourth film in a franchise, it’s a ton of fun.\r\n\r\nAnd though it’s action isn’t quite as entertaining as its predecessors and it’s unfortunate to see Awkwafina playing yet another thief (_Jumanji: The Next Level_ says hello), for the most part, _Kung Fu Panda 4_ happily skadooshes its way to animated greatness.\r\n\r\n**Full review:** https://bit.ly/KuFuPa4"
        }
      )
    end
  end
end