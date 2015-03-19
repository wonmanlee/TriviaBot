class AddUserColumns < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :score,    :integer, default: 0
  end
end
