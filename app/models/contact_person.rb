class ContactPerson < ActiveRecord::Base
  belongs_to :app
    
  validates_presence_of :contact_name, :app_id
  validates_numericality_of :app_id, :allow_nil => true
  validates_numericality_of :contact_phone, :allow_nil => true
  validates_format_of :contact_email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i, :allow_blank => true
end
