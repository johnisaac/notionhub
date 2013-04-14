# encoding: utf-8
class Link < ActiveRecord::Base
  belongs_to :user
  has_many :l_comments
  has_many :user_links
  
  before_create do |link| 
    link.flags = 1
    link.rating = 0
  end
  
  validates_presence_of :title, :URL, :user_id, :flags, :rating
  validates_numericality_of :user_id, :rating
  validates_length_of :title, :minimum => 5
  validates_format_of :URL, :with => /(?i)\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«“”‘’]))/i
  
  def self.change_rating( link_id, user_id, rating )
    link = Link.where("id = ?", link_id).first
    if !link.nil?
       puts "Link: #{link.inspect}"
       link.rating = link.rating + Integer(rating)
       if link.save
          return [1, link.rating, "Link Saved"]
       else
          return [-1, link.rating, "Link is not saved."]
       end
    else
       return [-1, "0", "Link Does Not Exist"]
    end
  end
  
  
  searchable do
    text :title
    integer :rating
  end
  handle_asynchronously :solr_index
end
