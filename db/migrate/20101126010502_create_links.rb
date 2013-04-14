class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :title, :null => false
      t.string :URL, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
