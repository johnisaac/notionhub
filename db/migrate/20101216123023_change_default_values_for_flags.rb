class ChangeDefaultValuesForFlags < ActiveRecord::Migration
  def self.up
    change_column :questions, :flags, :integer, :default => 1
    change_column :user_questions, :flagged, :integer, :default => 1
  end

  def self.down
    change_column :questions, :flags, :integer, :default => 0
    change_column :user_questions, :flagged, :integer, :default => 0
  end
end
