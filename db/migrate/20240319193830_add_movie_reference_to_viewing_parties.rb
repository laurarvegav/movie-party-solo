class AddMovieReferenceToViewingParties < ActiveRecord::Migration[6.0]
  def up
    add_reference :viewing_parties, :movie, foreign_key: true
  end

  def down
    remove_reference :viewing_parties, :movie, foreign_key: true
  end
end