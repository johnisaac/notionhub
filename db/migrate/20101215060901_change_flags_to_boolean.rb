class ChangeFlagsToBoolean < ActiveRecord::Migration
  def self.up
    change_column :questions, :flags, :boolean, :default => false
  end

  def self.down
    change_column :questions, :flags, :integer, :default => 0
  end
end
