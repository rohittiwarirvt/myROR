class CourseSection < ActiveRecord::Base
  belongs_to :version
  belongs_to :chapter
  has_many :contents, class_name: 'CourseSection', foreign_key: 'parent_id'
  has_many :resources, dependent: :destroy
  has_one :content_resource, dependent: :destroy, class_name: 'Resource',
  has_one :presentation
  has_one :custom_content
  has_one :interactive_slide
  has_one :assessment

end
