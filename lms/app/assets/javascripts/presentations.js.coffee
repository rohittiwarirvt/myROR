# This files presentation
#= require jquery.form
#= require jwplayer
#= require slides

$ ->
  s = undefined
  window.Presentation =
    settings:
      slide_id: $('#slide_id').val()
      presentation_id: $('#presentation_id').val()
      leftColumnId: $('#col_0')
      columnHeadingElement: $('.column-heading .slide-title')
      slideTitleElement: $('#slide_title')
      saveTitleBtnElement: $('#save_title')
      formElement: $('#slide_title').closest('form')
      saveLeftTextBtnElement: $('#saveTextLeft_0')
      leftCancelBtnElement: $('#cacelTextLeft_0')
      leftColumnContent: $('#textContent_0')
      leftColumnContentType: $('#contentType_0')
      leftLabelContent: $('#contentLabel_0')
      leftContentDiv: $('#contentDiv_0')
      leftEditBtnElement: $('#editColumn_0')
      leftRemoveBtnElement: $('#removeColumn_0')
      leftBtnWrapElement: $('#btnBox_0')
      leftTextFieldWrap: $('#textField_0')
      leftTextBtn: $('#addTextLeft_0')
      leftTextWrap: $('#textDiv_0')
      leftTextColumnDelete: $('#removeColumn_0')
      leftImageFielField: $('#rightImageFileField_0')
      leftImageDiv: $('#imageDiv_0')
      leftImageWrap: $('#rightColumnImage_0')
      leftImageDeleteBtn:  $('#delete_video_0')
      leftVideoFileField: $('#rightVideoFileField_0')
      leftVideoDeleteBtn: $('#delete_video_0')
      leftVideoWrap: $('#rightColumnVideo_0')
      leftLabelWrap: $('#labelField_0')
      # right column elements
      rightCancelBtnElement: $('#labelField_0')
      rightColumnContent: $('#labelField_0')
      rightColumnContentType: $('#labelField_0')
      rightLabelContent: $('#labelField_0')
      rightContentDiv: $('#labelField_0')
      rightEditBtnElement: $('#labelField_0')
      rightRemoveBtnElement: $('#labelField_0')
      rightBtnWrapElement: $('#labelField_0')
      rightTextFieldWrap: $('#labelField_0')
      rightTextBtn: $('#labelField_0')
      rightTextWrap: $('#labelField_0')
      rightTextColumnDelete: $('#labelField_0')
      rightImageFielField: $('#labelField_0')
      rightImageDiv: $('#labelField_0')
      rightImageWrap: $('#labelField_0')
      rightImageDeleteBtn: $('#labelField_0')
      rightVideoFielField: $('#labelField_0')
      rightVideoDeleteBtn: $('#labelField_0')
      rightVideoWrap: $('#labelField_0')
      rightLabelWrap: $('#labelField_0')
    init: ->
      console.log("test")
    bindUIActions: ->
      console.log("test")
    bindDynamicUIActions: ->
      console.log("test")
    textValidate: (el)->
      console.log("test")
    imageValidate: (el)->
      console.log("test")
    videoValidate: (el)->
      console.log("test")
    show_error: (el) ->
      console.log("test")
    hide_error: (el) ->
      console.log("test")
    initVideo: (el, url) ->
      console.log("test")
    cancelActionFrom: (el) ->
      console.log("test")

