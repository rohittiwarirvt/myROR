$ ->
  $presentationEditCtrl = $('.presentation-edit-controller')
  $editPresentation = $('.edit-presentation')
  $presentationLabel = $('.presentation-label')


  $presentationEditCtrl.hide()

  $editPresentation.on 'click', ->
    presCallback()

  presCallback = ->
    $presentationEditCtrl.toggle()
    $presentationLabel.toggle()
  $titleSave = $('#prt_save', $presentationEditCtrl)
  $titleCancel = $('.cancel', $presentationEditCtrl)

  $titleSave.on 'click', ->
    updateTitle(@)

  $titleCancel.on 'click', ->
    presCallback()


  $error = $('#error')

  updateTitle = (elem)->
    $titleinputValue = $('#ppt-edit-name')
    if $('#ppt-edit-name').val()
      $. ajax(
        type: 'put'
        url: 'update_ppt_title'
        data: $titleinputValue
        success: (data, textStatus, XHR) ->
          $error.hide()
          $presentationLabel.html data['title']
          presCallback()
        )
    else
      $error.show()

  # color picker for slide setting
  $('#color').colpick(
    layout: 'hex'
    submit: 1
    colorScheme: 'dark'
    onSubmit: (hsb, hex, rgb, el, bySetColor) ->
      console.log("teat")
    onChange: (hsb, hex, rgb, el, bySetColor) ->
      console.log("teat")
  ).keyup ->
    $(@).colpickSetColor @value
    return

  # image field
  $('.image-file-field').toggle($('#deleteImage').hasClass('hidden-area'))
