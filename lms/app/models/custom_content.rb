class CustomContent < ApplicationRecord
  belongs_to :course_section
  include Custom
  include CourseContent
  mount_uploader :zip, ZipUploader

  CONTENT_TYPE = ['application/zip', 'application/x-zip', 'application/x-zip-compressed', 'application/octet-stream']
  def unzip(params)
  end

  def check_file(dest, params)

  end

  def checkzip
  end

  def bucket_path
  end

  def delete_aws_directory
  end

  def upload_aws(dest)
  end
end
