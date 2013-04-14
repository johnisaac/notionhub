class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.integer :app_id, :null => false
      t.string :content, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
