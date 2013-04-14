class CreateTqAssociations < ActiveRecord::Migration
  def self.up
    create_table :tq_associations do |t|
      t.integer :topic_id, :null => false
      t.integer :question_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tq_associations
  end
end
