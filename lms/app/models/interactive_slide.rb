class InteractiveSlide < ActiveRecord::Base
  belongs_to :course_section
  has_many :interactive_slide_informations, dependent: :destroy

end
