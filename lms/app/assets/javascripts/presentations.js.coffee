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
      leftCancelBtnElement: $('#cancelTextLeft_0')
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
      s.leftTextColumnDelete.on 'click', ->
        data =
          id: s.slide.id
          presentation_id: s.slide.presentation_id
          slide:
            column_id: s.leftColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId, s.slide.presentationId, s.slide_id)
          type: 'delete'
          data: data
          success: (data, status) ->
            $('#col_0').val(data.slide.id)
            s.leftLabelContent.hide()
            s.leftBtnWrapElement.show()
      # hide text editor on click of cacncel
      s.leftCancelBtnElement.on 'click', (e) ->
        from = s.leftCancelBtnElement.data('from')
        s.leftTextFieldWrap.hide()
        if Presentation.cancelActionFrom(e)
          s.leftBtnWrapElement.show()
        else
          s.leftLabelContent.show()
      # remove left column content field
      s.leftRemoveBtnElement.on 'click', ->
        data =
          id: s.slide.id
          presentation_id: s.slide.presentation_id
          slide:
            column_id: s.leftColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId, s.slide.presentationId, s.slide_id)
          type: 'delete'
          data: data
          success: (data, status) ->
            s.leftLabelContent.hide()
            s.leftBtnWrapElement.show()
      #transition js
      $('a', '#transitionTypes').click (e)->
        $('#transition_val').val $(e.target).data('transition')
        form = s.uploadBackgroundImageFileField.closest('form')
        form.ajaxSubmit
          url: 'update_settings'
          dataType: 'json'
          type: 'put'
          success: (response) ->
            $(e.target).siblings().removeClass('active-transition')
            $(e.target).addClass('active-transition')

    bindDynamicUIActions: ->
      #upload backgroudn image for slide
      s.uploadBackgroundImageFileFieldElement.bind 'change', ->
        if Presentation.imageValidate(s.uploadBackgroundImageFileFieldElement)
          Presentation.show_error('#invalid_img')
        else
          s.formElement.ajaxSubmit
            url: 'update_settings'
            type: 'put'
            success: (data, status) ->
              $('.image-file-field').hide()
              imageUrl =  "url(#{data.background_img.url})"
              imageName = data.background_img.url.split('/').pop()
              s.columnWrapperElement.css 'background-image', imageUrl
              $('#imageName').text(imageName)
              s.deleteBackgroundImageField.show()
      #delete backgroudn image
      s.deleteBackgroundImageField.on 'click', ->
        if confirm $('#deleteImage').data('deletemessage')
          data =
            presentation_id: s.slide.presentationId
            id: s.slide.id
            slide:
              slide_setting_attributes:
                background_img: ''
          $.ajax
            url: 'delete_bg_img'
            type: 'put'
            data: data
            success: (data, status) ->
              s.columnWrapperElement.css 'background-image', 'none'
              s.deleteBackgroundImageField.hide()
              $('.image-file-field').show()
      #video button click
    textValidate: (el) ->
      el.length
    imageValidate: (el)->
      $.inArray(el.val().split('.').pop().toLowerCase(),['jpeg','jpg', 'png']) is -1
    videoValidate: (el)->
      $.inArray(el.val().split('.').pop().toLowerCase(), ['mp4']) is -1
    show_error: (el) ->
      console.log("test")
    hide_error: (el) ->
      console.log("test")
    initVideo: (el, url) ->
      console.log("test")
    cancelActionFrom: (el) ->
      el.target.dataset.from is s.actions['add']


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
