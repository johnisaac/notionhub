class AddFlaggedTimeToUserQuestions < ActiveRecord::Migration
  def self.up
    add_column :user_questions, :flagged_time, :datetime
  end

  def self.down
    remove_column :user_questions, :flagged_time
  end
end
