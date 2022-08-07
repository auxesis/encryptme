class AddStashIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stash_id, :string
    add_index :users, :stash_id
  end
end
