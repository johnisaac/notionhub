class ApplicationController < ActionController::Base
  protect_from_forgery
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception,                            :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,         :with => :render_not_found
    rescue_from ActionController::RoutingError,       :with => :render_not_found
    rescue_from ActionController::UnknownController,  :with => :render_not_found
    rescue_from ActionController::UnknownAction,      :with => :render_not_found
  end
  
  helper_method :status_list, :degree_list, :status_value, :degree_value, :department_list, :date_name, :app_deadline
  
  private
  def render_not_found(exception)
     render :template => "/error/404.html.erb", :status => 404
  end
  
  def render_error(exception)
    puts "---------------------------------------"
    puts "---------------not found---------------"
    puts "---------------------------------------"
    render :template => "/error/500.html.erb", :status => 500
  end
  
  def date_name(inputDate)
    newDate = Date.strptime(inputDate.to_s,"%Y-%m-%d %H:%M:%S %Z").strftime("%m/%d/%Y").split("/")
    return Date::ABBR_MONTHNAMES[newDate[0].to_i]+" "+newDate[1]+", "+newDate[2]
  end
  
  def app_deadline(inputDate)
    newDate = Date.strptime(inputDate.to_s,"%Y-%m-%d").strftime("%m/%d/%Y").split("/")
    return Date::ABBR_MONTHNAMES[newDate[0].to_i]+" "+newDate[1]+", "+newDate[2]
  end
  
  def status_list
    status_list = { "Applied" => 1, "Not Yet Applied" => 2, "Admitted" => 3, "Rejected" => 4}
    status_list
  end
  
  def degree_list
    degree_list = { "Bachelors" => 1, "Masters" => 2, "Ph.D" => 3}
    degree_list
  end
  
  def degree_value(degreeValue)
    case degreeValue
      when 1
        return "Bachelors"
      when 2
        return "Masters"
      when 3
        return "Ph.D"
    end
  end
  
  def status_value(statusValue)
    case statusValue
      when 1
        return "Applied"
      when 2
        return "Not Yet Applied"
      when 3
        return "Admitted"
      when 4
        return "Rejected"
    end
  end

  def department_list
    dept_list = {
        "Computer Science and Engineering" => "Computer Science and Engineering",
        "Electrical Engineering" => "Electrical Engineering",
        "Civil Engineering" => "Civil Engineering",
        "Mechanical Engineering" => "Mechanical Engineering",
        "Psychology" => "Psychology",
        "Material Science" => "Material Science",
        "Physics" => "Physics",
        "Chemistry" => "Chemistry",
        "Mathematics" => "Mathematics",
        "Others" => ""
    }
    return dept_list
  end
end
