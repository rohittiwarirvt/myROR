class QuestionsController < ApplicationController
  before_action :assessment_information, only: [:index, :new, :edit, :create]
  before_action :question_categories, only: [:new, :create]

  def index
    @questions = @assessment.questions.includes(:question_category).rank(
      :question_order).page(params[:page]).per(10)
    @total_questions = @assessment.questions.count
  end

  def new
    @question = Question.new
    @answers = @question.answers.build
    @version = @assessment.course_section.version
  end
  def assessment_information
    @assessment = Assessment.includes(:course_section).find_by_id(params[:assessment_id])
    @version = @assessment.course_section.version
  end

  def question_categories
    @questioncategories = QuestionCategory.order(:name)
  end
end
