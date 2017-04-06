# This is out Question model. It inherits from 'ApplicationRecord' which inherits from 'ActiveRecord:Base' which is a class that comes from Rails.
# All the functionalities we're oging to be using in our Question model come from 'ActiveRecord:Base' which leverages Ruby's meta programming features.

class Question < ApplicationRecord
has_many :answers, dependent: :destroy
  # dependent: : destroy will delete all associated answers before deleting the quesiton when you call 'question.destroy'.
  # dependent: :nullify will update the 'question_id' field to 'null' in all the associated answers before deleting the question when you call 'question.destroy'
  # ** remember to always have a 'dependent' option to your has_many **

# as of Rails 5, belongs to subject will enforce a validation that the association must be present by default.
# to make it optional, give belongs_to a second argument 'optional: true'
belongs_to :subject, optional: true

belongs_to :user, optional: true

# has_many :answers adds the following instance methods to this model, Question:

# answers
# answers<<(object, ...)
# answers.delete(object, ...)
# answers.destroy(object, ...)
# answers=(objects)
# answers_singular_ids
# answers_singular_ids=(ids)
# answers.clear
# answers.empty?
# answers.size
# answers.find(...)
# answers.where(...)
# answers.exists?(...)
# answers.build(attributes = {}, ...)
# answers.create(attributes = {})
# answers.create!(attributes = {})

  validates(:title, { presence: { message: 'must be present!' },
                      uniqueness: true })
  validates(:body,{ presence: true, length: { minimum: 5 } })
  validates(:view_count, { presence: true,
                           numericality: { greater_than_or_equal_to: 0 }})

  # this is used for custom-validation method, we expect to have a method called
  # `no_monkey` defined, ideally in the private section of the class
  validate :no_monkey

  after_initialize :set_defaults
  before_validation :titleize_title

  # scope :recent_five, lambda { order(created_at: :desc).limit(5) }
  def self.recent_five
    order(created_at: :desc).limit(5)
  end

  def self.recent(number)
    order(created_at: :desc).limit(number)
  end

  private

  def titleize_title
    self.title = title.titleize if title.present?
  end

  def set_defaults
    self.view_count ||= 0
  end

  def no_monkey
    if title.present? && title.downcase.include?('monkey')
      # this will make the record invalid, even if there is one error on the
      # record by using `errors.add` then the record won't save because it won't
      # be valid
      errors.add(:title, 'can\'t include monkey!')
    end
  end

end
