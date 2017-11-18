# This files presentation
#= require jquery.form
#= require jwplayer
#= require slides
#= require tinymce-jquery

$ ->
  s = undefined
  window.Presentation =
    settings:
      slide_id: $('#slide_id').val()
      presentation_id: $('#presentation_id').val()
      leftColumnId: $('#col_0')
      columnHeadingElement: $('.column-heading .slide-title')
      slideTitleElement: $('#slide_title')
      saveTitleBtnElement: $('#saveTitle')
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
      uploadBackgroundImageFileField: $('#bg_img')
      deleteBackgroundImageField: $('#deleteImage')
      columnWrapperElement: $('.column-wrapper')
      slide: $('#ids').data()
      actions:
        add: 'add'
        edit: 'edit'
    init: ->
      s = @settings
      @bindUIActions()
      @bindDynamicUIActions()
    bindUIActions: ->
      # Save slide title
      s.saveTitleBtnElement.on 'click', ->
        data = slide:
                title: tinyMCE.get('slide_title').getContent({format: 'html'})
        textData = tinyMCE.get('slide_title').getContent({format: 'text'})
        if textData.length > 30
          alert s.saveTitleBtnElement.data('validationmessage')
        else
          $.ajax
            url: 'update_title'
            type: 'put'
            dataType: 'json'
            data: data
            success: (data, status) ->
              $('#titleEditorWrapper').hide()
              $('.slide-title-panel .slide-title').addClass('updated-slide-title').show()
              s.columnHeadingElement.html(data.title)
      # text Button click
      s.leftTextBtn.on 'click', ->
        s.leftCancelBtnElement.attr('data-from', 'add')
        s.leftBtnWrapElement.hide()
        s.leftTextFieldWrap.show()
      s.saveLeftTextBtnElement.on 'click', ->
        data= tinyMCE.activeEditor.getContent()
        textData = tinyMCE.activeEditor.getContent({format: 'text'})
        if textData.trim().length > 500
          alert s.saveLeftTextBtnElement.data('validationmessage')
        else
          if Presentation.textValidate(data)
            s.leftColumnContent.val(data)
            s.leftColumnContentType.val('Text')
            s.formElement.ajaxSubmit
              url: 'update_contents'
              type: 'put'
              success: (data, status) ->
                s.leftTextFieldWrap.hide()
                s.leftContentDiv.html(data[0].content)
                s.leftLabelContent.show()
          else
            Presentation.show_error('#invalid_content')
      #delete left column text content
      #s.left
      #image button click



      #video button click

    bindDynamicUIActions: ->
      console.log("test")
    textValidate: (el) ->
      el.length
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

  Presentation.init()

  tinymce.init
    selector: 'textarea.title-tinymce'
    plugins: [
      'textcolor colorpicker'
    ]
    toolbar1: 'insertfile undo repo| stylesheet | bold italic| alignleft aligncenter alignright alighnjustify| forecolor backcolor'

  tinymce.init
    selector: 'textarea.tinymce'
    plugins: [
      'textcolor colorpicker'
    ]
    toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | forecolor backcolor '
