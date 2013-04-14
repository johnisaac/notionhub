class ChangeDepartmentToString < ActiveRecord::Migration
  def self.up
    change_column :apps, :department, :string
  end

  def self.down
    change_column :apps, :department, :integer
  end
end
