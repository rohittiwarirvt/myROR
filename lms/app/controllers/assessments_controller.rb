class AssessmentsController < ApplicationController
  before_action :set_version, except: [:index]
  before_action :set_assessment, only: [:show, :edit, :update, :destroy]

  # GET /assessments/new
  def new
    @assessment = Assessment.new
    @types = Assessment::TYPES
  end

  # Post /assessments
  def create
    @assessment = Assessment.new(assessment_params)
    @assessment.course_section_id = params[:course_section_id]
    if @assessment.save
      if params[:section_type].present?
        @assessment.sectionize_assessment
      else
        @assessment.sectionize_content
      end
      set_flash_message :success, :success
      redirect_to assessment_questions_path(@assessment)
    else
      render :new
    end
  end
  def  set_version
    @version = Version.find(params[:version_id])
  end

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def assessment_params
    params.require(:assessment).permit(
      :name, :description, :assessment_type,
      :passing_criteria, :passing_percentage,
      :number_of_displayed_questions, :course_section_id, :upfront,
      :additional_text, :details_page, :randomize)
  end
end
