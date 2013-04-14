class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :uid
  
  validates_presence_of  :provider, :uid
  validates_inclusion_of :provider, :in => ["facebook"]
end
