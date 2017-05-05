class Api::V1::QuestionsController < Api::BaseController

  #http://localhost:3000/api/v1/questions
  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @question = Question.find params[:id]

    # if the format is JSON and we're using jbuilder as our templating system
    # what file will be rendered?
    # /views/api/v1/questions/show.json.jbuilder

    render :show
  end

  def create
    question_params = params.require(:question).permit(:title, :body)

    question = Question.new question_params
    question.user = @user

    if question.save
      head :ok
    else
      render json: {error: question.errors.full_messages.join(', ') }
    end
  end

end
