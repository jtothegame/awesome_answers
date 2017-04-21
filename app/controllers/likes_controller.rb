class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @questions = user.liked_questions

    render 'questions/index'
  end

  def create
    question = Question.find(params[:question_id])

    if cannot? :like, question
      redirect_to(
        question_path(question),
        alert: 'Liking your own question is sad 😥'
      )
      return # early return to prevent execution of anything
      # after the redirect above
    end

    like = Like.new(user: current_user, question: question)

    if like.save
      redirect_to question_path(question), notice: 'Liked question! ❤️'
    else
      redirect_to question_path(question), alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])

    if cannot? :like, like.question
      redirect_to(
        question_path(question),
        alert: 'Un-liking your own question is prepostrous 😡'
      )
      return # early return to prevent execution of anything
      # after the redirect above
    end

    if like.destroy
      redirect_to question_path(like.question), notice: 'Un-liked question! 💔'
    else
      redirect_to question_path(like.question), alert: like.errors.full_messages.join(', ')
    end
  end
end
