#= require jquery.form
#= require colpick.js

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
      if !bySetColor
        $('#bg_color').val("##{hex}")
      $(el).colpickHide()
      form = $('.background-color').closest('form')
      form.ajaxSubmit
        url: 'update_settings'
        type: 'put'
        success: (data, status) ->
          $('.column-wrapper').css 'background-color', "##{hex}"
    onChange: (hsb, hex, rgb, el, bySetColor) ->
      $('.color-pick').css 'background-color', "##{hex}"
  ).keyup ->
    $(@).colpickSetColor @value
    return

  # image field
  $('.image-file-field').toggle($('#deleteImage').hasClass('hidden-area'))

  #slide title
  $('.slide-title-panel .slide-title').click ->
    $('#titleEditorWrapper').show()
    $(@).hide()
    return

  $('#titleEditorWrapper .cancel').click ->
    $('#titleEditorWrapper').hide()
    $('.slide-title-panel .slide-title').show()
    return

  displayVideo = (elementID, settings) ->
    defaults =
      height: 315
      width: 590
      swfPath: '/jwplayer/player.swf'
      controls: false
      autostart: true
    settings = $.extend({}, defaults, settings)
    settings['width'] = '100%' if settings['responsive']
    if $("##{elementID}").length > 0
      jwplayer(elementID).setup
        flashplayer: settings['swfPath']
        allowscriptaccess: 'always'
        files: settings['url']
        height: settings['height']
        width: settings['width']
        autostart: settings['autostart']


  $('.video').each ->
    index = $(@).data('index')
    video_url = $("#video_url_#{index}").val()
    displayVideo("videoWrap_#{index}", {
      url: video_url,
      controls: true,
      autostart: false,
      height: '250',
      width: '100%'
    })
