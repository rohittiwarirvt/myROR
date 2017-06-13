class Version < ActiveRecord::Base
  belongs_to :course
  belongs_to :category
  has_many :course_sections, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :evaluation_questions, dependent: :destroy
  has_and_belongs_to_many :version_roles, join_table: 'versions_roles'
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader

end
