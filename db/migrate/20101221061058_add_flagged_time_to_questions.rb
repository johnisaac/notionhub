class AddFlaggedTimeToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :flagged_time, :datetime
  end

  def self.down
    remove_column :questions, :flagged_time
  end
end
