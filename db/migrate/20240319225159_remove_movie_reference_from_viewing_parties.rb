class RemoveMovieReferenceFromViewingParties < ActiveRecord::Migration[7.1]
  def change
    remove_reference :viewing_parties, :movie, null: false, foreign_key: true
  end
end
