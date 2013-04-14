class CreateUserAnswers < ActiveRecord::Migration
  def self.up
    create_table :user_answers do |t|
      t.integer :answer_id, :null => false
      t.integer :user_id, :null => false
      t.integer :rating, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_answers
  end
end
