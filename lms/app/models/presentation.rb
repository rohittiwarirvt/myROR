class Presentation < ApplicationRecord
  has_many :slides, dependent: :destroy
  belongs_to :course_section
  accepts_nested_attributes_for :slides
  include CourseContent
end
