class ChangeDegreeToInteger < ActiveRecord::Migration
  def self.up
    change_column :apps, :degree, :integer
  end

  def self.down
    change_column :apps, :degree, :string
  end
end
