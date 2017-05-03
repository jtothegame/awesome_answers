class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: VALID_EMAIL_REGEX

  before_validation :downcase_email
  before_create :generate_api_token

  has_many :questions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  private

  def generate_api_token
    loop do
      self.api_token = SecureRandom.urlsafe_base64(32)
      break unless User.exists?(api_token: self.api_token)
    end
  end

  def downcase_email
    self.email.downcase! if email.present?
  end

  # if you add an attribute accessor to an ActiveRecord object then you will be able to capture that from the form and have it in memory but it will not be stored in the database if you don't have a database field for it

  #attr_accessor :abc

  # we don't have to do this for 'password' and 'password_confirmation' if we use 'f.password_field' because Rails automatically adds attribute accessors for these two special fields.

  has_secure_password
  # has_secure_password is a built in Rails method that helps us with user authentication.
  # 1. It will automatically add a presence validator for the password.
  # 2. When given a password it will generate a salt then it will hash the salt and password combo and will store the result of the Hashing (using bcrypt) along with the randomly generated salt into a database field called password_digest'
  # 3. If you skip 'password_confirmation' field then it won't give you a validation error. If you provide 'password_confirmation' then it will validate that the password matches the password_confirmation, otherwise it will throw an error and rollback the user when you try to save it.
  # 4. We will get a method called 'authenticate' that will help us test if the user has entered the correct password or not. (This can be tested in rails c)

end
