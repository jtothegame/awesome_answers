class Answer < ApplicationRecord
belongs_to :question

  # belongs_to :question adds the following instance methods to this model, Answer:
  # question
  # question=(associate)
  # build_question(attributes = {})
  # create_question(attributes = {})
  # create_question!(attributes = {})

validates :body, presence: true  
end
