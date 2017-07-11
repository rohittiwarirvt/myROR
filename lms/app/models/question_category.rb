class QuestionCategory < ApplicationRecord
  has_many :questions, dependent: :destroy
end
