# This files presentation
#= require jquery.form
#= require jwplayer
#= require slides

$ ->
  s = undefined
  window.Presentation =
    settings:
      slide_id:
      presentation_id
      leftColumnId
      columnHeadingElement
      slideTitleElement
      saveTitleBtnElement
      formElement
      saveLeftTextBtnElement
      leftCancelBtnElement
      leftColumnContent
      leftColumnContentType
      leftLabelContent
      leftContentDiv
      leftEditBtnElement
      leftRemoveBtnElement
      leftBtnWrapElement
      leftTextFieldWrap
      leftTextBtn
      leftTextWrap
      leftTextColumnDelete
      leftImageFielField
      leftImageDiv
      leftImageWrap
      leftImageDeleteBtn
      leftVideoFielField
      leftVideoDeleteBtn
      leftVideoWrap
      leftLabelWrap
      # right column elements
      rightCancelBtnElement
      rightColumnContent
      rightColumnContentType
      rightLabelContent
      rightContentDiv
      rightEditBtnElement
      rightRemoveBtnElement
      rightBtnWrapElement
      rightTextFieldWrap
      rightTextBtn
      rightTextWrap
      rightTextColumnDelete
      rightImageFielField
      rightImageDiv
      rightImageWrap
      rightImageDeleteBtn
      rightVideoFielField
      rightVideoDeleteBtn
      rightVideoWrap
      rightLabelWrap
    init: ->

    bindUIActions: ->
    bindDynamicUIActions: ->
    textValidate: (el)->
    imageValidate: (el)->
    videoValidate: (el)->
    show_error: (el) ->
    hide_error: (el) ->
    initVideo: (el, url) ->
    cancelActionFrom: (el) ->

