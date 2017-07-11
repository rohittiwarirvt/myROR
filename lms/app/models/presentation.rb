class Presentation < ApplicationRecord
  has_many :slides, dependent: :destroy
  belongs_to :course_section

end
