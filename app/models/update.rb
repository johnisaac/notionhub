class Update < ActiveRecord::Base
  belongs_to :app
  
  validates_presence_of :content, :app_id
  validates_numericality_of :app_id
  validates_length_of :content, :within => 0..140
end
