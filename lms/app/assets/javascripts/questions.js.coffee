#= require jquery_nested_form
#= require tinymce-jquery
$ ->
  window.lms = window.lms || {}
  lms.index = null
  lms.answer = ''
  lms.multipleMatching = ''
  lms.answerId = null
  lms.multipleMatchingId = null
  lms.dropDownString = ''
  lms.multipleMatchDropDown = ''
  lms.questionTypeClass = null
  lms.multipleTypeClass = null
  $('.answer-type').hide()
  question_type = $('#question_question_type').val()

  $('.custom-file-upload').wrap '<div class=\'custom-file-upload-wrap\'></div>'
  $customButton = '<button type=\'button\' class=\'btn-default\'>Choose File</button>'
  $customMsg = '<span class=\'custom-upload-file-name\'>Select a File</span>'
  $('.custom-file-upload').before $customButton
  $('.custom-file-upload-wrap').after $customMsg

  changeFileName =  (element) ->
    fileName = element.val().split('\\').pop()
    element.parent().next().text fileName

  $('.custom-file-upload').change ->
    changeFileName($(@))
    return

  #ajax calls for answer_options
  deleteAnswer= (url) ->
    $.ajax
      type: 'delete'
      url: url
      success: (data, status) =>
        data
  # disable options of question category
  removeOption = [6, 7, 8, 9]
  for key,value of removeOption
    $(".question-category-list option[value=#{value}]").hide()
