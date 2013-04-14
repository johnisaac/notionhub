class ChangeDepartmentToInteger < ActiveRecord::Migration
  def self.up
    change_column :apps, :department, :integer
  end

  def self.down
    change_column :apps, :department, :string
  end
end
