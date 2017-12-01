class CertificatesController < ApplicationController
  layout 'fullpage'

  def index
    @certificates = Certificates.all
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
    params.require(:certificate).permit(:title, :short_description, :description, :file, :role_id, :amount)
  end
end
