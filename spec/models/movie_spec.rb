require 'rails_helper'

RSpec.describe Movie, type: :model do
 describe 'validations' do
  it { should validate_presence_of :name }
  it { should validate_presence_of :vote }
  it { should validate_presence_of :runtime }
  it { should validate_presence_of :genre }
 end

 describe 'relationships' do
  it { should have_many :viewing_parties }
 end
end