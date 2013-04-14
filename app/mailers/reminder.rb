class Reminder < ActionMailer::Base
  default :from => "notionhub@gmail.com"
  
  def reminder_email(next_week, email)
     @user_apps = next_week
     mail(:to => email, :subject => "Weekly Status Update") do |format| 
        format.html { render 'reminder_email' } 
     end
  end
  
  def today_apps(today_list, email)
     @user_apps = today_list
     mail(:to => email, :subject => "Applications with today deadline") do |format| 
        format.html { render 'today_apps' } 
     end
  end
  
  def tomo_apps(tomo_list, email)
     @user_apps = tomo_list
     mail(:to => email, :subject => "Applications with tomorrow's deadline") do |format| 
        format.html { render 'tomo_apps' } 
     end
  end
  
  def new_answer(to, question_id,q_title,content)
    @q_id = question_id
    @q_title = q_title
    @content = content
    mail(:to => to, :subject => "NotionHub: There is a new answer for your question") do |format| 
       format.html { render 'new_answer' } 
    end
  end
  
  def welcome_email(id, email, name)
    @name = name
    @id = id
    mail(:to => email, :subject => "Welcome to NotionHub") do |format|
      format.html { render 'welcome_email' }
    end
  end
end
