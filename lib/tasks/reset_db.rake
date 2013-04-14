namespace :migrate do
  task :questions => :environment do
    @questions = Question.all
    @questions.each do |question|
      question.flags = 1
      question.rating = 0
      question.flagged_time = nil
      question.save
    end
    @links = Link.all
    @links.each do |link|
      link.flags = 1
      link.rating = 0
      link.flagged_time = nil
      link.save
    end
    
    @answers = Answer.all
    @answers.each do |answer|
      answer.rating = 0
      answer.save
    end
    
    @user_questions = UserQuestions.all
    @user_questions.each do|uq|
      uq.flagged_time = nil
      uq.rating = 0
      uq.flagged = 1
      uq.save
    end
    
    @user_links = UserLinks.all
    @user_links.each do|ul|
      ul.flagged_time = nil
      ul.rating = 0
      ul.flagged = 1
      ul.save
    end
    
    @user_answers = UserAnswers.all
    @user_answers.each do|ua|
      ua.rating = 0
      ua.save
    end
  end
end
