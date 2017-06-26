$(".notice").html("<%= escape_javascript(flash[:notice] %>")
$('#course_section_name').focusin ->
  $('.notice').fadeOut(1000)
