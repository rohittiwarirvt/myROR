class Question < ApplicationRecord
  belongs_to :assessment
  has_many :answers, dependent: :destroy
  belongs_to :question_category
  accepts_nested_attributes_for :answers, allow_destroy: true
  include RankedModel
  ranks :question_order, with_same: :assessment_id
  QUESTION_CATEGOTY_TYPE = %w(sorting match_the_pairs multiple_matching)

  def parse_option
    QUESTION_CATEGOTY_TYPE.include?(question_category.name)
  end
end
