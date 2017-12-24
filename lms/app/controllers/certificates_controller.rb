class CertificatesController < ApplicationController
  layout 'fullpage'
  before_action :find_certificate, except: [:index, :new, :create, :publish]
  before_action :find_published_courses, except: [:index, :show, :destroy]
  before_action :certificate_published_courses, only: [:edit, :show]
  before_action :certificate_roles, only: [:new, :edit, :create]

  def index
    @certificates = Certificate.all
  end

  def edit
  end

  def update
    if @certificate.update_attributes(certificate_params)
      redirect_to certificates_path
    else
      render :edit
    end
  end

  def create
    @certificate  = Certificate.new(certificate_params)
    if @certificate.save
      redirect_to certificates_path
    else
      render :new
    end
  end

  def find_certificate
    @certificate = Certificate.find(params[:id])
  end

  def new
    @certificate = Certificate.new
  end

  def certificate_params
    params.require(:certificate).permit(:name, :short_description, :description, :file, :role_id, :amount)
  end

  def certificate_roles
    @roles = Role.order('title')
  end

  def certificate_published_courses
    @courses = @courses.to_a
    @courses << @certificate.courses
    @courses = @courses.flatten.uniq
  end

  def find_published_courses
    @courses = Course.published_versions
  end

  def destroy
    if @certificate.course_ids.present? && @certificate.certification_taken?
      redirect_to certificates_path
      set_flash_message :danger, :message
    else
      @certificate.destroy
      redirect_to certificates_path
      set_flash_message :success, :delete_certificate
    end

  end
end
