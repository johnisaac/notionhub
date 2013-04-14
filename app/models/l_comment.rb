class LComment < ActiveRecord::Base
  belongs_to :link
  
  validates_presence_of :user_id, :link_id, :content
  validates_numericality_of :user_id, :link_id
  validates_length_of :content, :minimum => 5
  
  searchable do
    text :content
  end
  handle_asynchronously :solr_index
end
