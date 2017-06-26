class Presentation < ActiveRecord::Base
  has_many :slides, dependent: :destroy
  belongs_to :course_section

end
