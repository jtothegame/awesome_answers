class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # When validating a presence of a boolean field, it will fail on 'false' value because false is treated as non-present. The presence validator will use '.present?' under the hood which will return false for an entry that is false:
  # true.present? => true
  # false.present? => false
  validates :is_up, inclusion: { in: [true, false] }

  validates :user_id, uniqueness: { scope: :question_id,
                                    message: 'already voted!'}
end
