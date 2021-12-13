class ChangeUserRoles < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :admin
    add_column :users, :role, :string
  end
end
