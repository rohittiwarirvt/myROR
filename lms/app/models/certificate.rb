class Certificate < ApplicationRecord
  has_and_belongs_to_many :courses, join_table: 'courses_certificates'
  has_one :role
  COURSE_COMPLETE_STATUS = 2
      # Return array of courses objects asociated with certificate
  def associated_course_versions
    courses.includes(:versions)
  end

  # Return array of courses ids asociated with certificate
  def associated_course_ids
    course_ids
  end

  def update_certificate
    update_attributes(editable: false)
  end

  def certification_taken?
    associated_course_versions.map do |course|
      return true unless course.versions.first.editable
    end
    false
  end

end
