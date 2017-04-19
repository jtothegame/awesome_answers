class RemindQuestionOwnerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    question_id = args[0]
    question = Question.find question_id
    if question.answers.count == 0
      # email question owner
      puts ">>>>>>> NO ANSWERS FOR THIS QUESTION"
    end  
  end
end
