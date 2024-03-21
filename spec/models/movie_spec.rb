require 'rails_helper'

RSpec.describe Movie do
  before do
    @data_movie = {
    genres: [
        {
        id: 28,
        name: "Action"
        },
        {
        id: 12,
        name: "Adventure"
        },
        {
        id: 16,
        name: "Animation"
        },
        {
        id: 35,
        name: "Comedy"
        },
        {
        id: 10751,
        name: "Family"
        }
      ],
    id: 1011985,
    original_title: "Kung Fu Panda 4",
    overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
    vote_average: 6.894,
    runtime: 94
    }

    @data_reviews
    @movie_kfp = Movie.new(@data)
  end
  describe ".initialize" do
    it 'exists' do
      movie_kfp = Movie.new(@data)

      expect(movie_kfp).to be_a(Movie)
    end

    it 'populates attributes correctly' do

      expect(@movie_kfp.id).to eq(1011985)
      expect(@movie_kfp.title).to eq('Kung Fu Panda 4')
      expect(@movie_kfp.vote).to eq(6.89)
      expect(@movie_kfp.summary).to eq('Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.')
    end
  end

  describe 'format_reviews' do
    it 'formats reviews into a hash where the keys are authors and values are the reviews' do
      
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
      expect(@movie_kfp.cast.length).to be_between(1, 10)
    end

    it 'formats cast into a hash where the keys are characters and values are the actors names' do
      expect(@movie_kfp.cast).to eq("Po (voice)"=> "Jack Black", "Zhen (voice)"=> "Awkwafina", "li(voice)"=> "Bryan Cranston", "The chameleon (voice)"=> "Viola Davis", "Shifu (voice)"=> "Dustin Hoffman", "Mr. Ping (voice)"=> "James Hong", "Tai Lung (voice)"=> "Ian McShane", "Han (voice)"=> "Ke Huy Qua", "Fish (voice)"=> "Ronny Chieng", "Granny Boar (voice)"=> "Lori Tan Chinn")
    end
  end
end