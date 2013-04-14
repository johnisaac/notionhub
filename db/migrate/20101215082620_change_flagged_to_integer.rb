class ChangeFlaggedToInteger < ActiveRecord::Migration
  def self.up
    change_column :questions, :flags, :integer, :default => 0
    change_column :user_questions, :flagged, :integer, :default => 0    
  end

  def self.down
    change_column :questions, :flags, :boolean, :default => false
    change_column :user_questions, :flagged, :boolean, :default => false
  end
end
