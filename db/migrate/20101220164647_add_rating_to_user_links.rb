class AddRatingToUserLinks < ActiveRecord::Migration
  def self.up
    add_column :user_links, :rating, :integer
  end

  def self.down
    remove_column :user_links, :rating
  end
end
