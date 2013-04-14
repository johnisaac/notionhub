class CreateContactUs < ActiveRecord::Migration
  def self.up
    create_table :contact_us do |t|
      t.string :content
      t.string :name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_us
  end
end
