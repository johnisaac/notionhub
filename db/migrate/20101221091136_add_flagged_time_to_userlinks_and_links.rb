class AddFlaggedTimeToUserlinksAndLinks < ActiveRecord::Migration
  def self.up
    add_column :user_links, :flagged_time, :datetime
    add_column :links, :flagged_time, :datetime    
  end

  def self.down
    remove_column :user_links, :flagged_time
    remove_column :links, :flagged_time
  end
end
