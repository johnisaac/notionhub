class AddRatingToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :rating, :integer, :default => 0
  end

  def self.down
    remove_column :links, :rating
  end
end
