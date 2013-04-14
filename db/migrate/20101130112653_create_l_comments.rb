class CreateLComments < ActiveRecord::Migration
  def self.up
    create_table :l_comments do |t|
      t.integer :user_id, :null => false
      t.integer :link_id, :null => false
      t.text :content, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :l_comments
  end
end
