class Assessment < ActiveRecord::Base
  belongs_to :course_section
  has_many :questions , dependent: :destroy
end

