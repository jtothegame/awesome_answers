class Subject < ApplicationRecord
  validates :name, uniqueness: true
  has_many :questions
end
