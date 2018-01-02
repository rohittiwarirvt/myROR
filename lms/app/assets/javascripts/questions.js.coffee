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
  removeOption = [1, 2, 8, 4]
  for key,value of removeOption
    $(".question-category-list option[value=#{value}]").hide()


  tinymce.init
    selector: 'textarea.tinymce'
    plugins: [
      'textcolor colorpicker'
    ]
    toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | forecolor backcolor '

  # select the correct answer
  $('.answer-type').on 'click', '.single-check', ->
    $('.single-check').not(@).prop('checked', false)

  # show respective answer type questions
  if question_type?
    $('.answer-type').hide()
    editable = $('#correct_answer_option_').data('disabled')
    $('.answer-type').find('input').attr('disabled', 'disabled')
    $(".answer-#{question_type}").show()
    $(".answer-#{question_type} input[type=text]").addClass('required');
    if editable is false
      $(".answer-#{question_type}").find('input').removeAttr('disabled')
    else if editable is true
      $(".answer-#{question_type}").find('input[type=text]').removeAttr('disabled')
      $(".answer-#{question_type}").find('input[type=hidden]').removeAttr('disabled')

  $('#question_question_category_id').on 'change', ->
    previous_option = $(@).data('prev')
    $(".answer-#{previous_option}").find('input').attr('disabled', 'disabled')
    $('.correct-message').empty()
    $('.answer-type').hide()
    $(".answer-#{$(@).val()}").show().find('input').removeAttr('disabled')
    $(".answer-#{$(@).val()} input[type=text]").addClass('required');
    $(".answer-#{$(@).val()} input[type=file]").addClass('required');
    if question_type?
      $(".answer-#{question_type}").find('input').val('')
    $(@).data('prev', $(@).val())
