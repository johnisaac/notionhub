class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :project_id, :null => false
      t.integer :user_id, :null => false
      t.string :activity, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
