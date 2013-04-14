class CreateAComments < ActiveRecord::Migration
  def self.up
    create_table :a_comments do |t|
      t.integer :answer_id, :null => false
      t.text :content, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :a_comments
  end
end
