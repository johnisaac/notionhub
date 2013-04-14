class CreateContactPeople < ActiveRecord::Migration
  def self.up
    create_table :contact_people do |t|
      t.string :contact_name, :null => false
      t.string :contact_email
      t.integer :contact_phone
      t.integer :app_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_people
  end
end
