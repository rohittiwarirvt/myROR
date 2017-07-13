class Video < Resource
  include CourseContent
  belongs_to :course_section
  belongs_to :content_section, class_name: 'CourseSetion'
  mount_uploader :video, VideoUploader
end
