class Presentation < ApplicationRecord
  has_many :slides, dependent: :destroy
  belongs_to :course_section
  accepts_nested_attributes_for :slides
  include CourseContent

  # def valid.presentation?
  #   slides.each do |slide|
  #     return false unless slide.valid_slide?
  #   end
  #   true
  # end
end
