class AddUserTypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_type, :integer, :default => 2
  end

  def self.down
    remove_column :users, :user_type
  end
end
