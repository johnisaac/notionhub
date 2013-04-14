class AddFlagsToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :flags, :integer
  end

  def self.down
    remove_column :questions, :flags
  end
end
