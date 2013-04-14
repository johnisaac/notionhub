class AddFlagsToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :flags, :integer, :default => 1,:null => false
  end

  def self.down
    remove_column :links, :flags
  end
end
