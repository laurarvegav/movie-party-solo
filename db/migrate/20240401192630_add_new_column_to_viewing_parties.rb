class AddNewColumnToViewingParties < ActiveRecord::Migration[7.1]
  def change
    add_column :viewing_parties, :host_user_id, :integer
  end
end
