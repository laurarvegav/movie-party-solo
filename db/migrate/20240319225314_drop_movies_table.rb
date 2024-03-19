class DropMoviesTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :movies
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
