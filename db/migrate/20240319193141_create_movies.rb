class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :vote
      t.string :runtime
      t.string :genre

      t.timestamps
    end
  end
end
