old_content = $('#new-section-chapter-' + "<%= @cs %>").html()
$('#new-section-chapter-' + "<%= @cs %>").empty()
.append("<%= j render(partial: 'course_sections/form',\
 locals: {version: @version, chapter: @chapter, course_section: @course_section} ) %>")
$('.cancel-edit').click ->
  $('#new-section-chapter-' + "<%= @cs %>").empty().append(old_content)
