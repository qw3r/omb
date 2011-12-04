class AddUsernameColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, default: '', null: false
    add_index :users, :username, unique: true
  end
end
