class CourseSection < ActiveRecord::Base
  belongs_to :version
  belongs_to :chapter, class_name: 'CourseSection', foreign_key: 'parent_id'
  has_many :contents, class_name: 'CourseSection', foreign_key: 'parent_id'
  has_many :resources, dependent: :destroy
  has_one :content_resource, dependent: :destroy, class_name: 'Resource', foreign_key: 'content_section_id'
  has_one :presentation
  has_one :custom_content
  has_one :interactive_slide, dependent: :destroy, foreign_key: 'content_section_id'
  has_one :assessment
  include RankedModel
  scope :chapters, ->{ where(parent_id: nil)}
end
