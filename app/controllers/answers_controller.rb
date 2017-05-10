class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    answer_params = params.require(:answer).permit(:body)
    @answer = Answer.new(answer_params)
    @answer.question = @question

    # @answer = @question.answers.build(answer_params) is the same as doing @answer.question = @question

  respond_to do |format|
      if @answer.save
        #sending an email to the question's owner.
        AnswersMailer.notify_question_owner(@answer).deliver_later
        format.html { redirect_to question_path(@question), notice: 'Answer Created!' }
        format.js   { render :success }
      else
        format.html { render '/questions/show' }
        format.js   { render :failure}
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    respond_to do |format|
    format.html { redirect_to question_path(@answer.question), notice: 'Answer deleted!' }
    format.js { render } # this will render 'destroy.js.erb'
    end
  end
end
