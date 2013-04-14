class AddRatingToUserQuestions < ActiveRecord::Migration
  def self.up
    add_column :user_questions, :rating, :integer
    add_column :questions, :rating, :integer, :default => 0
  end

  def self.down
    remove_column :user_questions, :rating
    remove_column :questions, :rating
  end
end
