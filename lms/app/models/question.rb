class Question < ApplicationRecord
  belongs_to :assessment
  has_many :answers, dependent: :destroy
  belongs_to :question_category
  include RankedModel
  ranks :question_order, with_same: :assessment_id
end
