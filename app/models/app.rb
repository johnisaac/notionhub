class App < ActiveRecord::Base
  belongs_to :user
  has_one :contact_person, :dependent => :destroy
  has_many :updates, :dependent => :destroy
  
  #accepts_nested_attributes_for :contact_person, :reject_if => Proc.new {|contact_person| contact_person[:contact_name].blank?}
  
  #validations
  validates_presence_of :university, :department, :degree, :status, :user_id
  validates_numericality_of :status, :user_id, :degree

  validates_inclusion_of :status, :in => 1..4 
  validates_inclusion_of :degree, :in => 1..4
  validates_acceptance_of :deadline, :if => Proc.new {|app| !app.deadline.nil? && app.deadline.past?}
  
  
  def self.send_status
    @users = User.all
    @users.each do |user|
      user_apps = App.find(:all,:conditions => ["user_id = ? AND deadline <= ? AND deadline >=?", user.id, Date.today+7, Date.today])
      app_list = {}
      user_apps.each do|app|
        app_list[ app.id ] = [ app.university, app.deadline, app.id , app.status]
      end
      puts app_list.inspect
      
      if app_list.length > 0
        Reminder.reminder_email(app_list , user.email).deliver!
        app_list = []
        user_apps = nil
      end
    end
  end
  
  def self.apps_today
    mail_details = App.mail_list(Date.today)
 
    mail_details[1].each_pair do |key, value|
       Reminder.today_apps(mail_details[0][key], value.email).deliver! if mail_details[0].length > 0
    end 
  end
  
  def self.apps_tomo
    mail_details = App.mail_list(Date.today + 1)

    mail_details[1].each_pair do |key, value|
      #Reminder.tomo_apps(mail_details[0][key], value.email).deliver! if mail_details[0].length > 0
      puts mail_details[0][key]
    end  
  end
  
  private
  def self.mail_list(deadline)
    apps = App.where(["status = ? AND deadline >= ? AND deadline <= ?", 2, Date.today, deadline]).order("user_id")
    
    user_list = []
    email_list = {}
    apps_list = {}
    user_apps = []
    
    apps.each do|app|
      if not user_list.include?(app.user_id)
         user_list.push(app.user_id) 
         email_list[app.user_id] = User.find(app.user_id)
      end
    end
    
    user_list.each do|user_id|
      apps_list[user_id] = []
    end
    
    user_list.each do|user_id|
      apps.each do|app|
        if app.user_id == user_id
          user_apps.push(app)
        end
      end
      apps_list[user_id] = user_apps
      user_apps = []
    end
    
    return [apps_list, email_list]
  end
end
