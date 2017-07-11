if $(".content-form").length
  $(".content-form").closest(".new-content-section").addClass("removed")

if $("#new-section-chapter-#{<%= @section.id %>}").length
  content = "#new-section-chapter-#{<%= @section.id %>}"
  new_content = true
  $(content).parent().removeClass('removed')
else
  content = "#course_section_#{<%= @section.id %>}"

old_content = $(content).html

$(content)
  .empty()
  .append("<%= j render(partial: 'resources/content_form',\
           locals: { version: @version, \
                     section: @section, \
                    resource: @resource}) %>")
$('html, body').animate {
  scrollTop: $(content).offset().top
}, 300
$('.cancel-edit').click ->
  $(content).empty().append(old_content)
  $(content).parent().addClass('removed') if new_content

