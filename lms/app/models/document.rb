class Document < Resource
  belongs_to : content_section, class_name: "CourseSection"
  belongs_to : course_section
end
