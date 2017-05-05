===============================API==============================================
1. go to questions_controller >

# def show
#     @answer = Answer.new
#     #render 'questions/show'
#
#     # 'respond_to' method allows us to render different outcomes depending on
#     # the format of the requests. Remember that the feautl format for any
#     # request in Rails applications is HTML
#     respond_to do |format|
#       # This 👇 means that if the format of the request is HTML then we will
#       # render the 'show' template (questions/show.html.erb)
#       format.html  { render :show }
#
#       #this👇 will will render `json` if the format of the request is JSON.
#       # ActiveRecord has a built-in feature to generate JSON from any object of
#       # ActiveRecord.
#       format.json  { render json: @question }
#     end
#   end

2. make a subfolder in controller call 'api'

3. go to terminal and run >

# rails g controller api/v1/questions

4. delete questions_helper.rb and run
rm - r app/assets/javascripts/api/v1
rm - r app/assets/stylesheets/api/v1

5. go to api > questions_controller.rb and add :

# def show
#   @question = Question.find params[:id]
#   # render json: question.to_json
#
#   # if the format is JSON and we're using jbuilder as our templating system
#   # what file will be rendered?
#   # /views/api/v1/show.json.jbuilder
#
# end

6. go to routes and and add :


  # namespace :api do
  #   namespace :v1 do
  #     # /api/v1/questions.json # => INDEX
  #     # /api/v1/questions/1.json # => SHOW
  #     resources :questions, only: [:index, :show]
  #   end
  # end'
 7. create a file and folder in these following path:

 # views/api/v1/questions/show.json.jbuilder

 8. then you can check the link in chrome as such:
 # http://localhost:3000/api/v1/questions/387.json

 9. in api > quesitons_conroller.rb add :

  # def index
  #   @questions = Question.order('created_at DESC')
  # end

10. create 'index.json.jbulider' in the api/v1/questions folder and add:

# json.array! @questions do |question|
#   json.id question.id
#   json.title question.title
#   json.url api_v1_question_url(question)
#
# end

11. and you can check it in chrome with the url:

# http://localhost:3000/api/v1/questions.json

=============================Active Serializer ================================
12. add gem 'gem 'active_model_serializers''

13. run the following command in terminal:

# rails g serializer question

14. go to app/controller/api/v1/questions_controller:

# rails g controller api/v1/products


# render json: @question

15. in question_serializer.rb add :

# class QuestionSerializer < ActiveModel::Serializer
#   attributes :id, :titleized_title, :body
#
#   # this will send an array of associated answers with the question using
#   # the answer serializer
#   has_many :answers
#
#   def titleized_title
#     object.title.titleize
#   end
# end


16. you can check it in chrome by visiting:

# http://localhost:3000/api/v1/questions/387

17. for answer use :

# rails g serializer answer

18 . then in answer_serializer.rb add:

class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
end


====================API KEY/TOKEN===============================================

19. run the following command in the terminal :

# rails g migration add_api_token_to_users api_token

20. go to the add_api_token_to_users file and add :

# class AddApiTokenToUsers < ActiveRecord::Migration[5.0]
#   def change
#     add_column :users, :api_token, :string
#     add_index :users, :api_token
#   end
# end

 then run db:migrate

 21. go to rails c and use one the following to generate api key/token :

 # SecureRandom.hex(32)
 or
 # SecureRandom.urlsafe_base64(32)

 22. go to user.rb and add :

  #  before_create :generate_api_key

  and in private method

  # def generate_api_key
  #     loop do
  #       self.api_token = SecureRandom.urlsafe_base64(32)
  #       break unless User.exists?(api_token: self.api_token)
  #     end
  #   end

 23. to UPDATE existing user with api token, run the following commands :

 # User.where(api_token: nil).each {|u| u.update(api_token: SecureRandom.urlsafe_base64(32)) }

 24. go to controllers/api/v1/questions_controller.rb add :

 # before_action :authenticate_user

 and

  #  private
  #   def authenticate_userq
  # end

25. go to rails c to grab random api_token using:

# User.last.api_token

then go to postman and run  :

# http://localhost:3000/api/v1/questions/387.json?api_token=9cE-YnZfKa1QYcpcNTlSuXlU2B7CW_ORO97B5SKOHFA

to get access

================================================================================

26. create a file 'awesome_answers_client.rb' by manuallyc creating it in one folder directory above or run

atom awesome_answers_client.rb when you are in one folder directory above

27. add the following in awesome_answers_client.rb :
#
# require 'faraday'
# require 'json'
#
# BASE_URL = 'http://localhost:3000/api/v1'
# API_TOKEN = '9cE-YnZfKa1QYcpcNTlSuXlU2B7CW_ORO97B5SKOHFA'
#
# conn = Faraday.new(:url => BASE_URL) do |faraday|
#   faraday.request  :url_encoded
#   faraday.response :logger
#   faraday.adapter  Faraday.default_adapter
# end
#
# response = conn.get "/questions?api_token=#{API_TOKEN}"
#
# questions = JSON.parse(response.body)
#
# questions.each do |question|
#   puts '🔫🔫🔫🔫🔫🔫🔫🔫🔫🔫🔫🔫🔫🔫'
#   puts questions['title']
#   puts '👍👍👍👍👍👍👍👍👍👍👍👍👍👍'
# end


make sure to grab the api_token from rails c

28. go back to the terminal and run 'gem install faraday'

29. start the server, open another terminal tab and run

ruby awesome_answers_client.rb
