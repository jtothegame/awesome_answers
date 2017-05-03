class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :titleized_title, :body

  # this will send an array of associated answers with the question using the
  # answer serializer.
  has_many :answers

  def titleized_title
    object.title.titleize
  end
end
