# ModuleName: RatingLogic 
# Purpose: to be included in all the models which needs rating
# Created: 10/12/2010
# Author: John Felix
# Methods:
# => id_value
# => increase_rating(object_id, user_id)
# => decrease_rating(object_id, user_id)
# => insert_rating(object_id, user_id, rating, type_detail)
# => update_rating(object, new_rating, type_detail)

module RatingLogic
  
  def id_value
    # Retrieve the [ClassName, primary_key] based on the name of the id value user input parameter
    case
      when  self.name == "UserAnswers" then
        return [Kernel.const_get("Answer"), "answer_id"]
      when  self.name == "UserQuestions" then
        return [Kernel.const_get("Question"), "question_id"]
      when  self.name == "UserLinks" then
        return [Kernel.const_get("Link"), "link_id"]
    end       
  end
  
  def increase_rating(object_id, user_id)
    # After the retrieving the [ClassName, PrimaryKey] using the id_value method,
    # use it to check whether the user has a record associated with the object,
    # If the user has a record,
    # => update the record 
    # Else
    # => insert the record
     type_detail = id_value()
     @user_results = where("#{type_detail[1]} = ? AND user_id = ?", object_id, user_id).first # i need the id type value
     if @user_results.nil?
       return insert_rating(object_id, user_id, 1, type_detail)
     else
       return update_rating(@user_results, 1, type_detail)
     end
   end

   def decrease_rating(object_id, user_id)
     # After the retrieving the [ClassName, PrimaryKey] using the id_value method,
     # use it to check whether the user has a record associated with the object,
     # If the user has a record,
     # => update the record 
     # Else
     # => insert the record
     type_detail = id_value()
     @user_results = where("#{type_detail[1]} = ? AND user_id = ?", object_id, user_id).first # i need the id type value
     if @user_results.nil?
       return insert_rating(object_id, user_id, -1, type_detail)
     else
       return update_rating(@user_results, -1, type_detail)
     end
   end

   def insert_rating(object_id, user_id, rating, type_detail)
     # Create a new UserSpecific record using the input parameters
     # Call the Change Rating specific to the class
     # Save the new record and return [1 or -1, new rating value, rating message]
     new_rating = new("#{type_detail[1]}".to_sym => object_id, :user_id => user_id, :rating => rating) # how are you going to pass the answer_id, question_id or link_id
     change_rating = type_detail[0].change_rating(object_id, user_id, rating)# we need the class name here
     if change_rating[0] == 1 && new_rating.save
        return [1, change_rating[1], "Rating is updated."]
     else
        return [-1, change_rating[1], "Oops! There is a problem while updating the rating. Please try again later."]
     end
   end

   def update_rating(object, new_rating, type_detail)
     # Create a Old UserSpecific record using the input parameters
     # Call the Change Rating specific to the class
     # Update the altered record and return [1 or -1, new rating value, rating message]
     # Update the Question's Rating and save it
        if object.rating != Integer(new_rating)
           object.rating = new_rating
           change_rating = type_detail[0].change_rating(object["#{type_detail[1]}"], object.user_id, new_rating) # I need the class name here, may be i can check the object type
           puts change_rating.inspect
           if change_rating[0] == 1 && object.save
              return [1, change_rating[1], "Rating is updated"]
           else
             return [-1, change_rating[1], "Oops! There is a problem while updating the rating. Please try again later."]
           end
        else
          q_rating = type_detail[0].select("rating").where("id = ?",object["#{type_detail[1]}"]).first # I need the class name here,
          return [-2, -2000, "You have already rated this..."]
        end
   end
end