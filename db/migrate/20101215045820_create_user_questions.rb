class CreateUserQuestions < ActiveRecord::Migration
  def self.up
    create_table :user_questions do |t|
      t.integer :question_id, :null => false
      t.integer :user_id, :null => false
      t.boolean :flagged, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_questions
  end
end
