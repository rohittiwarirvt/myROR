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

  # select the correct answer
  $('.answer-type').on 'click', '.single-check', ->
    $('.single-check').not(@).prop('checked', false)

  # add more options for sorting
  $('.add-option-fields').on 'click', ->
    index = $(@).prev('.fields').find('.form-group').data('index')
    if($(@).parent().children('.fields').size() > $('#question_max_option').val())
      alert($('#question_max_option').attr('data-message'))
      return false
    cloneElement = $(@).prev('.fields').find(".row-#{index}").html()
    regex = new RegExp(index, 'gi');
    regexIndex = new RegExp(index+1, 'gi');
    createElement = cloneElement.replace(regexIndex, index + 2)
    addElement = createElement.replace(regex, index + 1)
    newElement = $.parseHTML("<div class='fields'><div class='form-group row-#{index + 1}' data-index='#{index + 1}'>#{addElement}</div></div>")
    newElement = $(newElement)
    if $('.edit_question').length
      sequence_no = $(newElement).find('.sequence').val()
      sort_no = parseInt(sequence_no) + 1
      newElement.find('.sequence').val(sort_no)
      newElement.find('.sequence').prev('.caption').html(sort_no)
    newElement.find('input[type=file]').addClass('required')
    newElement.find('img').attr({ src: '', alt: ''})
    newElement.find('input[type=text]').attr('value','')
    newElement.find('input[type=checkbox]').attr('checked', false)
    newElement.find('input[type=radio]').attr('checked', false)
    newElement.find('.custom-upload-file-name').text('Select a File')
    newElement.find('.custom-file-upload').change ->
      changeFileName($(@))
      return
    $(@).before(newElement)

  answerClass =(e) ->
    lms.index = $(e).attr('data-index')
    lms.answer = $(self).parent().parent().parent()
      .find("#question_answers_attributes_#{lms.index}_id")
    lms.answerId = lms.answer.val()
    if lms.answerId
      lms.dropDownString = lms.answer.parent().parent()
        .attr('class').split(' ')[0]
      lms.questionTypeClass = lms.dropDownString.replace('"','')

  $('.answer-type').on 'click', '.delete-answer', ->
    answerClass(this)
    if $(@).closest(".fields .row-#{lms.index}").length
      if($(@).closest(".row-#{lms.index}").parent().parent().children('.fields').size() < $('#question_min_option').val())
        alert($(@).attr('data-delete'))
        return false
      else if ($('.edit_question').length) && lms.answerId && ($(".#{lms.questionTypeClass} .fields > input").length >= $('#question_min_option').val())
        deleteAnswerInDb(this)
      else if ($('.edit_question').length) && lms.answerId && ($(".#{lms.questionTypeClass} .fields > input").length < $('#question_min_option').val())
        alert($('.submit_form').attr('data-conditional-delete'))
        return false
      $(@).closest(".row-#{lms.index}").parent().remove()
    else
      if($(this).closest(".row-#{lms.index}").parent().children('.form-group').size() < $('#question_min_option').val())
        alert($(@).attr('data-delete'))
        return false
      $(@).closest(".row-#{lms.index}").remove()

  # delete option for multiple matching there should be minimum two answer options
  $('.answer-type').on 'click', '.multiple-matching-delete-answer', ->
    multipleMatchingClass(this)
    if $(@).closest(".largeText .row-#{lms.index}").length
      if($(@).closest(".row-#{lms.index}").parent().parent().parent().find('.largeText').size() < $('#question_min_option').val())
        alert($(@).attr('data-delete'))
        return false
      else if ($('.edit_question').length) && lms.multipleMatchingId && ($(".#{lms.multipleTypeClass} .fields > input").length >= $('#question_min_option').val())
        deleteAnswerInDb(this)
      else if ($('.edit_question').length) && lms.multipleMatchingId && ($(".#{lms.multipleTypeClass} .fields > input").length < $('#question_min_option').val())
        alert($('.submit_form').attr('data-conditional-delete'))
        return false
      $(@).closest(".largeText .row-#{lms.index}").parent().remove()
    else
      if($(this).closest(".largeText .row-#{lms.index}").parent().children('.form-group').size() < $('#question_min_option').val())
        alert($(@).attr('data-delete'))
        return false
      $(@).closest(".largeText .row-#{lms.index}").remove()

  # multipleMatchingClass
  multipleMatchingClass =(e) ->
    self = e
    lms.index = $(self).attr('data-index')
    lms.multipleMatching = $(self).parent().parent().parent().parent()
      .find("#question_answers_attributes_#{lms.index}_id")
    lms.multipleMatchingId = lms.multipleMatching.val()
    if lms.multipleMatchingId
      lms.multipleMatchDropDown = lms.multipleMatching.parent().parent().attr('class').split(' ')[0]
      lms.multipleTypeClass = lms.multipleMatchDropDown.replace('"','')

  #delete option for multiplematching on new form
   $('.answer-type').on 'click', '.new-multiple-match-delete-answer', ->
     if $(@).closest('.largeText').length
       if ($(@).parent().parent().parent().parent().find('.largeText').size() < $('#question_min_option').val())
         alert($(@).attr('data-delete'))
         return false
       else
         $(@).closest('.largeText').remove()

  # set the correct matching pair value
  $('.answer-type').on 'blur', '.match-pair', ->
    option = {}
    optionIndex = $(@).attr('data-option')
    if $("#question_match_#{optionIndex}__left_option").length
      leftOption = $("#question_match_#{optionIndex}__left_option").val()
      rightOption = $("#question_match_#{optionIndex}__right_option").val()
      element = $("#question_match_#{optionIndex}__option")
    else
      leftOption = $("#left_option_#{optionIndex}").val()
      rightOption = $("#right_option_#{optionIndex}").val()
      element = $("#question_answers_attributes_#{optionIndex}_option")
    option[leftOption] = rightOption
    element.val JSON.stringify(option)
    return

  # set the position of elements to be sorted
  $('.answer-type').on 'blur', '.sorting', ->
    option = {}
    optionIndex = $(@).attr('data-option')
    if $("#question_sort_#{optionIndex}__sequence").length
      element = $("#question_sort_#{optionIndex}__sequence")
      optionElement = $("#question_sort_#{optionIndex}__option")
    else
      element = $("#question_answers_attributes_#{optionIndex}_sequence")
      optionElement = $("#question_answers_attributes_#{optionIndex}_option")
    sequence = element.val()
    sort = $(@).val()
    option[sequence] = sort
    optionElement.val JSON.stringify(option)


  # check count of multiple match options
  $('.answer-type').on 'click', '.add-multiple-match', ->
    index = $(@).attr('data-rightindex')
    $wrapper = $(@).parent().parent().find('.multiple-match')
    count =  $wrapper.length
    if $('.edit_question').length
      inputId = $wrapper.data('option')
    else
      inputId = index
    if count < $('#question_max_multiple_match').val()
      index++
      inputField = $wrapper.parent().append getInputField inputId,index
      cloneElement = $(@).parent('.manipulate-option').html()
      addOptionIndex = $(@).attr('data-rightindex')
      addManipulationElement = cloneElement.replace(addOptionIndex, index)
      optionHtml = $.parseHTML("<div class='input-field manipulate-option pull-right'>#{addManipulationElement}</div>")
      inputField.append optionHtml
      $(@).parent('.manipulate-option').remove()
      $(@).parent().find('.multiple-match-delete-answer').attr('data-rightindex',index)
    else
      alert($(@).data('maxlimit'))

  # get input field of multiple match option
  getInputField = (inputId, index) ->
    input = document.createElement('input')
    input.setAttribute 'type', 'text'
    input.setAttribute 'name', "question[multiple[#{inputId}]][right_option[#{index}]]"
    input.setAttribute 'id', "question_match_#{inputId}__right_option[#{index}]"
    input.setAttribute 'class', 'input-super-large multiple-match'
    input.setAttribute 'data-option', index
    return input
  do ->
    $('.content').hide()
    delete_click = true
    # accordian should not expand on click of delete
    $('.btn-delete, .btn-edit').on 'click', ->
      delete_click = false
      return

    $('.accordion-items li').on 'click', ->
      if delete_click
        $(@).find('.accord-content').stop().slideToggle()
        $(@).siblings().find('.accord-content').slideUp()
      delete_click = true

  # re-position questions
  $('.re-position').sortable(
    items: '.question'
    update: (e, ui) ->
      assessment_id = $('.accordion-items').data('assesmentId')
      id = ui.item.data('question-id')
      position = ui.item.index()
      $.ajax(
        type: 'put'
        dataType: 'json'
        url: Routes.assessment_question_update_position_path(assessment_id, id)
        data: { question: { question_order_position: position } }
      )
      total = $('.sr-no').length
      $('.sr-no').each (i) ->
        if i < total
          $(@).text(++i)
  )

  # add more options for match the pair
  $('.add-option-match-pair').on 'click', ->
    index = $(@).prev('.form-group').data('index') || $(@).prev('.fields').find('.form-group').data('index')
    if($(@).parent().children('.form-group').size() > $('#question_max_option').val())
      alert($('#question_max_option').attr('data-message'))
      return false
    cloneElement = $(@).prev(".row-#{index}").html() || $(@).prev('.fields').find(".row-#{index}").html()
    regex = new RegExp(index, 'gi');
    addElement = cloneElement.replace(regex, index + 1)
    if $('.edit_question').length
      newElement = $.parseHTML("<div class='fields'><div class='form-group row-#{index + 1}' data-index='#{index + 1}'>#{addElement}</div></div>")
    else
      newElement = $.parseHTML("<div class='form-group row-#{index + 1}' data-index='#{index + 1}'>#{addElement}</div>")
    $(newElement).find('input[type=text]').val('')
    $(@).before(newElement) || $(@).prev(".row-#{index}").after(newElement)

  # add more options for sorting
  $('.add-option-fields').on 'click', ->
    index = $(@).prev('.fields').find('.form-group').data('index')
    if($(@).parent().children('.fields').size() > $('#question_max_option').val())
      alert($('#question_max_option').attr('data-message'))
      return false
    cloneElement = $(@).prev('.fields').find(".row-#{index}").html()
    regex = new RegExp(index, 'gi');
    regexIndex = new RegExp(index+1, 'gi');
    createElement = cloneElement.replace(regexIndex, index + 2)
    addElement = createElement.replace(regex, index + 1)
    newElement = $.parseHTML("<div class='fields'><div class='form-group row-#{index + 1}' data-index='#{index + 1}'>#{addElement}</div></div>")
    newElement = $(newElement)
    if $('.edit_question').length
      sequence_no = $(newElement).find('.sequence').val()
      sort_no = parseInt(sequence_no) + 1
      newElement.find('.sequence').val(sort_no)
      newElement.find('.sequence').prev('.caption').html(sort_no)
    newElement.find('input[type=file]').addClass('required')
    newElement.find('img').attr({ src: '', alt: ''})
    newElement.find('input[type=text]').attr('value','')
    newElement.find('input[type=checkbox]').attr('checked', false)
    newElement.find('input[type=radio]').attr('checked', false)
    newElement.find('.custom-upload-file-name').text('Select a File')
    newElement.find('.custom-file-upload').change ->
      changeFileName($(@))
      return
    $(@).before(newElement)

  # add more options for multiple match
  $('.add-option-multiple-match').on 'click', ->
    index = $(@).prev('.largeText').find('.form-group').data('index') || $(@).prev('.fields').find('.largeText').data('index')
    count = $(@).parent().children('.largeText').size() || $(@).parent().children('.fields').size()
    if($(@).parent().children('.largeText').size() > $('#question_max_option').val())
      alert($('#question_max_option').attr('data-message'))
      return false
    cloneElement = $(@).prev('.largeText').find(".row-#{index}").html() || $(@).prev('.fields').find('.largeText').find(".row-#{index}").html()
    regex = new RegExp(index, 'gi');
    addElement = cloneElement.replace(regex, index + 1)
    newElement = $.parseHTML("<div class='largeText' data-index='#{index + 1}'><div class='form-group row-#{index + 1}' data-index='#{index + 1}'>#{addElement}</div></div>")
    $(newElement).find('input[type=text]').val('')
    $(@).before(newElement)

  # delete multiple match option
  $('.answer-type').on 'click', '.multiple-match-delete-answer', ->
    index = $(@).attr('data-index')
    if($(@).closest('.right-field').find('input[type=text]').size() <= $('#question_min_multiple_match').val())
      alert($(@).attr('data-delete'))
      return false
    $(@).parent().prev('input[type=text]').remove()


  # delete option for sorting
  $('.answer-type').on 'click', '.sorting-delete-answer', ->
    answerClass(this)
    if($(".row-#{lms.index}").parent().parent('.sorting-option').children('.fields').size() < $('#question_min_option').val())
      alert($(@).attr('data-delete'))
      return false
    else if ($('.edit_question').length) && lms.answerId && ($(".#{lms.questionTypeClass} .fields > input").length >= $('#question_min_option').val())
      deleteAnswerInDb(this)
    else if ($('.edit_question').length) && lms.answerId && ($(".#{lms.questionTypeClass} .fields > input").length < $('#question_min_option').val())
      alert($('.submit_form').attr('data-conditional-delete'))
      return false
    $(".sorting-option .row-#{lms.index}").parents('.fields').remove()
  # checked value the correct answer
  $('.answer-type').on 'change', '.single-check', ->
    if $(@).is(':checked')
      $(@).parent().parent().parent().parent('.single-option').find('.correct-hidden').val('0')
      $(".option-#{$(@).data('option')}").val('1')
    else
      $(".option-#{$(@).data('option')}").val('0')
