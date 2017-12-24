class Assessment < ApplicationRecord
  belongs_to :course_section
  has_many :questions , dependent: :destroy

  include CourseContent

  # Removing test and practise(Assessment as quiz type was only
  # supportes { test: 'Test', quiz: 'Quiz', practice: 'Practice' })
  TYPES = { quiz: 'Quiz' }
  PASSING_CRITERIA_YES = true
  PASSING_CRITERIA_NO = false
  ASSESSMENT = 'Assessment'

  def editable?
    return true if course_section.version.editable?
    if passing_criteria_changed? || assessment_type_changed? ||
       passing_percentage_changed? ||
       no_of_displayed_questions_changed?
      false
    else
      true
    end
  end

  def valid_assessment?
    questions.any? && (no_of_displayed_questions.to_i <= questions.count)
  end
end

