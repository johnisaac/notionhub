class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  has_many :apps, :dependent => :destroy
  has_many :feedbacks
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :links, :dependent => :destroy
  has_many :user_questions
  has_many :user_answers
  has_many :authentications, :dependent => :destroy
  has_many :topic_users
  has_many :topics, :through => :topic_users
  
  after_create :send_welcome_email
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_attached_file :photo,
     :storage => :s3,
     :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
     :styles => { 
       :big => "200x200>",
       :medium => "150x150>", 
       :thumb => "100x100>",
       :small => "25x25#" 
      },
     :path => "/:style/:filename"
     
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :photo
  validates_presence_of :name
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def update_with_password(params={}) 
    if params[:password].blank? && !authentications.empty?
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
      update_attributes(params) 
    else
      super
    end 
  end 
  
  private
  def send_welcome_email
    Reminder.welcome_email(self.id, self.email, self.name).deliver!
  end
end
