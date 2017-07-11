class Assessment < ApplicationRecord
  belongs_to :course_section
  has_many :questions , dependent: :destroy
end

