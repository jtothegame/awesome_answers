class VotesController < ApplicationController
  before_action :authenticate_user!
  # TO DO: build and enforce permissions for the actions in this controller.

  def create
      question = Question.find params[:question_id]
      vote = Vote.new is_up: params[:is_up],
                      user: current_user,
                      question: question

    if vote.save
      # redirecting to question is the same as doing:
      #redirect_to question_path(question)
      redirect_to question, notice: '😄'
    else
      redirect_to question, alert: vote.errors.full_messages.join(', ')
    end
  end

  def destroy
    vote = Vote.find params[:id]
    vote.destroy
    redirect_to question_path(vote.question), notice: 'Unvoted!'
  end

  def update
    vote = Vote.find params[:id]
    vote.is_up = params[:is_up]

    if vote.save
      redirect_to vote.question, notice: 'Vote Changed'
    else
      redirect_to vote.question, alert: vote.errors.full_messages.join(', ')
    end
  end
end
