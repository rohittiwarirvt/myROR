$('#course-content').empty().append("<%= j render(partial: 'course_sections/syllabus',\
  locals: {chapters: @chapters, version: @version}) %>")
$('#course_section_name').val('')
loadSyllabus()
loader false
