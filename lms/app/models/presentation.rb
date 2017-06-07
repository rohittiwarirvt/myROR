class Presentation < ActiveRecord::Base
  has_many : slides, dependend: :destroy
  belongs_to : course_section

end
