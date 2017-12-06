class CertificatesController < ApplicationController
  layout 'fullpage'
  before_action :find_certificates, except: [:index, :new, :create, :publish]
  before_action :find_published_course, except: [:index, :show, :destroy]
  before_action :certificate_published_courses, only: [:edit, :new, :create]
  before_action :certificate_roles, only: [:new, :edit, :create]

  def index
    @certificates = Certificate.all
  end

  def edit
  end

  def update
  end

  def create
    @certificate  = Certificate.new(certificate_params)
    if @certificate.save
      redirect_to certficate_path
    else
      render :new
    end
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
end
