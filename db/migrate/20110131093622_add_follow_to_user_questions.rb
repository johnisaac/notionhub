class AddFollowToUserQuestions < ActiveRecord::Migration
  def self.up
    add_column :user_questions, :follow, :boolean, :default => false
  end

  def self.down
    remove_column :user_questions, :follow
  end
end
