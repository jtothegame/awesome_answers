class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  # the `before_action` method registers another method in this case it's the
  # `find_question` method which will be executed just before the actions you
  # specify in the `only` array. Keep in mind that the method that gets executed
  # as a `before_action` happens within the same request/response cycle so if
  # you define an instance variable you can use it within the action / views
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def new
    # we instaniate a new `Question` object because it will help us in
    # generating the form in `views/new.html.erb`. We have to make it an
    # instance variable so we can access it in the view file.
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    @question.user = current_user
    if @question.save

      RemindQuestionOwnerJob.set(wait: 5.days).perform_later(@question.id)
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path(@question.id)

      # Rails gives us access to `flash` object which looks like a Hash. flash
      # utilizes cookies to store a bit of information that we can access in the
      # next request. Flash will automatically be deleted when it's displayed.
      flash[:notice] = 'Question created!'
      redirect_to question_path(@question)
    else
      # render 'questions/new'

      # if you want to show a flash message when you're doing `render` instead
      # of `redirect` meaning that you want to show he flash message within the
      # same request/response cycle, then you will need to use flash.now
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

  def show
    @answer = Answer.new
  end

  def index
    @questions = Question.last(20)
  end

  def edit
    # can? is a helper method that came from the CanCanCan which helps us enforce permission rules in the controllers and views.
    redirect_to root_path, alert: 'access denied' unless can? :edit, @question
  end

  def update
    if !(can? :edit, @question)
      redirect_to root_path, alert: 'access denied'
    elsif @question.update(question_params)
      redirect_to question_path(@question), notice: 'Question updated'
    else
      render :edit
    end
  end

  def destroy
    if can? :destroy, @question
      @question.destroy
      redirect_to questions_path, notice: 'Question Deleted'
    else
      redirect_to root_path, alert: 'Access Denied'
    end
  end

  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    # the line below is what's called "Strong Parameters" feautre that was added
    # to Rails starting with version 4 to help developer be more explicit about
    # the parameters that they want to allow the user to submit
    params.require(:question).permit([:title, :body, { tag_ids: [] } ])
  end

end
