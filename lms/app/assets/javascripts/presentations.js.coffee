# This files presentation
#= require jquery.form
#= require slides
#= require jwplayer
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
      leftImageFileField: $('#rightImageFileField_0')
      leftImageDiv: $('#imageDiv_0')
      leftImageWrap: $('#rightColumnImage_0')
      leftImageDeleteBtn:  $('#delete_img_0')
      leftVideoFileField: $('#rightVideoFileField_0')
      leftVideoDeleteBtn: $('#delete_video_0')
      leftVideoWrap: $('#rightColumnVideo_0')
      leftLabelWrap: $('#labelField_0')
      # right column elements
      # right column elements
      saveRightTextBtnElement: $('#saveTextLeft_1')
      rightCancelBtnElement: $('#cancelTextLeft_1')
      rightColumnId: $('#col_1')
      rightColumnContent: $('#textContent_1')
      rightColumnContentType: $('#contentType_1')
      rightLabelContent: $('#contentLabel_1')
      rightContentDiv: $('#contentDiv_1')
      rightEditBtnElement: $('#editColumn_1')
      rightRemoveBtnElement: $('#removeColumn_1')
      rightBtnWrapElement: $('#btnBox_1')
      rightTextFieldWrap: $('#textField_1')
      rightTextBtn: $('#addTextLeft_1')
      rightTextWrap: $('#textDiv_1')
      rightTextColumnDelete: $('#removeColumn_1')
      rightImageFileField: $('#rightImageFileField_1')
      rightImageDiv: $('#imageDiv_1')
      rightImageWrap: $('#rightColumnImage_1')
      rightImageDeleteBtn: $('#delete_img_1')
      rightVideoFileField: $('#rightVideoFileField_1')
      rightVideoDeleteBtn: $('#delete_video_1')
      rightVideoWrap: $('#rightColumnVideo_1')
      rightLabelWrap: $('#labelField_1')
      #manifest Url adding to slide right
      rightVideoManifestButton: $('#leftVideoManifestField_1'),
      rightVideoManifestWrap: $('#manifestVideoUrl_1')
      rightVideoManifestEditElement: $('#editManifestColumn_1')
      rightVideoManifestRemoveElement: $('#removeManifestColumn_1')
      rightVideoMainfestContentDiv: $('#manifest_file_1')
      saveRightManifestBtnElement: $('#saveManifestTextLeft_1')
      rightCancelManifestBtnElement: $('#cancelManifestTextLeft_1')
      rightManifestContentDiv: $('#manifestContentDiv_1')
      rightManifestLabelContent: $('#manifestContentLabel_1')
      uploadBackgroundImageFileFieldElement: $('#bg_img')
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
          presentation_id: s.slide.presentationId
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
          presentation_id: s.slide.presentationId
          slide:
            column_id: s.leftColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId, s.slide.presentationId, s.slide_id)
          type: 'delete'
          data: data
          success: (data, status) ->
            s.leftLabelContent.hide()
            s.leftBtnWrapElement.show()
      # show text input on edit click
      s.leftEditBtnElement.on 'click', ->
        s.leftCancelBtnElement.attr('data-from', 'edit')
        s.leftLabelContent.hide()
        s.leftTextFieldWrap.show()
      #transition js
      $('a', '#transitionTypes').click (e)->
        $('#transition_val').val $(e.target).data('transition')
        form = s.uploadBackgroundImageFileFieldElement.closest('form')
        form.ajaxSubmit
          url: 'update_settings'
          dataType: 'json'
          type: 'put'
          success: (response) ->
            $(e.target).siblings().removeClass('active-transition')
            $(e.target).addClass('active-transition')
      # right column functions
      # save right column text content
      s.saveRightTextBtnElement.on 'click', ->
        data = tinyMCE.activeEditor.getContent()
        textData = tinyMCE.activeEditor.getContent({format: 'text'})
        if textData.trim().length > 500
          alert s.saveRightTextBtnElement.data('validationmessage')
        else
          if Presentation.textValidate(data)
            s.rightColumnContent.val(data)
            s.rightColumnContentType.val('Text')
            s.formElement.ajaxSubmit
              url: 'update_contents'
              type: 'put'
              success:(data, status) ->
                s.rightTextFieldWrap.hide()
                s.rightContentDiv.html(data[1].content)
                s.rightLabelContent.show()
          else
          Presentation.show_error('#invalid_content')
      # delete right column text content
      s.rightTextColumnDelete.on 'click', ->
        data = id: s.slide_id, presentation_id: s.presentation_id, slide: column_id: s.rightColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId,s.slide.presentationId, s.slide.id)
          type: 'delete'
          data: data
          success: (data, status) ->
            s.rightColumnId.val(data.slide.id)
            s.rightLabelContent.hide()
            s.rightBtnWrapElement.show()
      # show text editor on add text
      s.rightTextBtn.on 'click', ->
        s.rightCancelBtnElement.attr('data-from', 'add')
        s.rightBtnWrapElement.hide()
        s.rightTextFieldWrap.show()
      # hide text editor on cancel
      s.rightCancelBtnElement.on 'click', (e) ->
        s.rightTextFieldWrap.hide()
        if Presentation.cancelActionFrom(e)
          s.rightBtnWrapElement.show()
        else
          s.rightLabelContent.show()
      # show text input on edit click
      s.rightEditBtnElement.on 'click', ->
        s.rightCancelBtnElement.attr('data-from', 'edit')
        s.rightLabelContent.hide()
        s.rightTextFieldWrap.show()
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
              imageUrl =  "url(#{data.background_image.url})"
              imageName = data.background_image.url.split('/').pop()
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
                background_image: ''
          $.ajax
            url: 'delete_bg_img'
            type: 'put'
            data: data
            success: (data, status) ->
              s.columnWrapperElement.css 'background-image', 'none'
              s.deleteBackgroundImageField.hide()
              $('.image-file-field').show()
      s.leftImageFileField.change (e) ->
        if Presentation.imageValidate(s.leftImageFileField)
          Presentation.show_error('#invalid_img')
        else
          s.leftColumnContentType.val('Image')
          s.formElement.ajaxSubmit
            url: 'update_contents'
            type: 'put'
            success: (data, status, xhr) ->
              s.leftImageFileField.val('')
              imageUrl = data[0].file_url.url
              html = "<img src=#{imageUrl}>"
              s.leftBtnWrapElement.hide()
              s.leftImageDiv.html(html)
              s.leftImageWrap.show()
      # delete  image for left column
      s.leftImageDeleteBtn.on 'click', (e) ->
        data =
          id: s.slide.id
          presentation_id: s.slide.presentationId
          slide:
            column_id: s.leftColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId,s.slide.presentationId, s.slide.id)
          type: 'delete'
          data: data
          success: (data, status) ->
            s.leftColumnId.val(data.slide.id)
            s.leftImageWrap.hide()
            s.leftBtnWrapElement.show()
      #upload video column for left column
      s.leftVideoFileField.change (e) ->
        if Presentation.videoValidate(s.leftVideoFileField)
          Presentation.show_error('#invalid_video')
        else
          s.leftColumnContentType.val('Video')
          s.formElement.ajaxSubmit
            url: 'update_contents'
            type: 'put'
            success: (data, status, xhr) ->
              s.leftVideoFileField.val('')
              videoUrl = data[0].file_url.url
              s.leftBtnWrapElement.hide()
              s.leftVideoWrap.show()
              Presentation.initVideo('videoWrap_0', videoUrl)
      # delete video for left column
      s.leftVideoDeleteBtn.on 'click', (e) ->
        data = id: s.slide.id, presentation_id: s.slide.presentationId, slide: column_id: s.leftColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId,s.slide.presentationId, s.slide.id)
          type: 'delete'
          data: data
          success: (data, status) ->
            s.leftColumnId.val(data.slide.id)
            s.leftBtnWrapElement.show()
            s.leftVideoWrap.hide()
      # Right Column image and video operations
      # Right column image upload
      s.rightImageFileField.change (e) ->
        if Presentation.imageValidate(s.rightImageFileField)
          Presentation.show_error('#invalid_img')
        else
          loader(true)
          s.rightColumnContentType.val('Image')
          s.formElement.ajaxSubmit
            url: 'update_contents'
            type: 'put'
            success:(data, status, xhr) ->
              s.rightImageFileField.val('')
              loader(false)
              imageUrl = data[1].file_url.url
              html = "<img src=#{imageUrl}>"
              s.rightBtnWrapElement.hide()
              s.rightImageDiv.html(html)
              s.rightImageWrap.show()
      # Delete image from right column
      s.rightImageDeleteBtn.on 'click', (e) ->
        data = id: s.slide.id, presentation_id: s.slide.presentationId, slide: column_id: s.rightColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId, s.slide.presentationId, s.slide.id)
          type: 'delete'
          data: data
          success: (data, status) ->
            s.rightColumnId.val(data.slide.id)
            s.rightImageWrap.hide()
            s.rightBtnWrapElement.show()
      # upload video for right column
      s.rightVideoFileField.change (e) ->
        if Presentation.videoValidate(s.rightVideoFileField)
          Presentation.show_error('#invalid_video')
        else
          loader(true)
          s.rightColumnContentType.val('Video')
          s.formElement.ajaxSubmit
            url: 'update_contents'
            type: 'put'
            success:(data, status, xhr) ->
              s.rightVideoFileField.val('')
              loader(false)
              videoUrl = data[1].file_url.url
              s.rightBtnWrapElement.hide()
              s.rightVideoWrap.show()
              Presentation.initVideo('videoWrap_1', videoUrl)
      # delete video for right column
      s.rightVideoDeleteBtn.on 'click', (e) ->
        data = id: s.slide.id, presentation_id: s.slide.presentationId, slide: column_id: s.rightColumnId.val()
        $.ajax
          url: Routes.destroy_column_version_course_section_presentation_slide_path(s.slide.version, s.slide.csId,s.slide.presentationId, s.slide.id)
          type: 'delete'
          data: data
          success: (data, status) ->
            s.rightColumnId.val(data.slide.id)
            s.rightBtnWrapElement.show()
            s.rightVideoWrap.hide()
    textValidate: (el) ->
      el.length
    imageValidate: (el)->
      $.inArray(el.val().split('.').pop().toLowerCase(),['jpeg','jpg', 'png']) is -1
    videoValidate: (el)->
      $.inArray(el.val().split('.').pop().toLowerCase(), ['mp4']) is -1
    show_error: (el) ->
      $(el).show()
    hide_error: (el) ->
      $(el).hide()
    initVideo: (el, url) ->
      jwplayer(el).setup
        width: '100%'
        file: url
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
