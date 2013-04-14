class CreateUserLinks < ActiveRecord::Migration
  def self.up
    create_table :user_links do |t|
      t.integer :link_id, :null => false
      t.integer :user_id, :null => false
      t.integer :flagged, :null => false, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :user_links
  end
end
