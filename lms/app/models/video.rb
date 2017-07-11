class Video < Resource
  belongs_to :course_section
  belongs_to :content_section, class_name: 'CourseSetion'
end
