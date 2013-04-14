class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :university, :null => false
      t.string :department, :null => false
      t.string :degree, :null => false
      t.date :deadline
      t.integer :status, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
