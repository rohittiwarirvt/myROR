class Version < ActiveRecord::Base
  belongs_to :course
  belongs_to :category
  has_many :course_sections, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :evaluation_questions, dependent: :destroy

end
