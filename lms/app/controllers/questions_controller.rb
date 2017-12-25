class QuestionsController < ApplicationController
  before_action :assessment_information, only: [:index, :new, :edit, :create]
  before_action :question_categories, only: [:new, :create]
  before_action :question_information, only: [:edit, :update]

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

  # POST /courses
  def create
    @question = Question.new(question_params)
    if @question.save
      set_flash_message :notice, :success
      redirect_to assessment_questions_path(params[:question][:assessment_id])
    else
      render :new
    end
  end

  def assessment_information
    @assessment = Assessment.includes(:course_section).find_by_id(params[:assessment_id])
    @version = @assessment.course_section.version
  end

  def question_categories
    @questioncategories = QuestionCategory.order(:name)
  end

  def question_params
    json_question_type = if params[:action] == 'update'
                           [:match, :sort]
                         else
                           [:match, :sort, :multiple]
                         end
    json_question_type.each do |questiontype|
      if params[:question][questiontype].present?
        params[:question][:answers_attributes] =
          params[:question][questiontype]
      end
    end
    params.require(:question).permit(
    :id, :title, :question_category_id, :assessment_id, answers_attributes:
    [:id, :option, :correct_answer, :image])
  end

  def question_information
    @question = Question.find(params[:id])
  end
end
