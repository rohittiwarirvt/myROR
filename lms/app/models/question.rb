class Question < ActiveRecord::Base
  belongs_to : assessment
  has_many : answers, dependent : :destroy
  belongs_to : question_category
end
