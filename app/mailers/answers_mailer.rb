class AnswersMailer < ApplicationMailer

  def notify_question_owner(answer)
    # you can share instance variables with templates the same way we do with Rails controllers.
    @answer = answer
    @question = answer.question
    @user = @question.user    

    # this will render app/views/answers_mailer/notify_question_owner.html.erb
    # and/or app/views/answers_mailer/notify_question_owner.text.erb
    mail(to: @user.email, subject: 'You got an answer!') if @user
  end
end
