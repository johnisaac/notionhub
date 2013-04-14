class RemoveAnsweredFromQuestions < ActiveRecord::Migration
  def self.up
    remove_column :questions, :answered
  end

  def self.down
    add_column :questions, :answered, :boolean
  end
end
