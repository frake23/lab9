class UpdateUsersTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean
    add_index :users, :username, unique: true
  end
end
