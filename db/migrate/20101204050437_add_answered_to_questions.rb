class AddAnsweredToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :answered, :boolean
  end

  def self.down
    remove_column :questions, :answered
  end
end
