$ ->
  courseSectionOrder = (item) ->
    $(item).each ->
      index = $(@).index()
      #label =

  resetLabelOrder = ->
    courseSectionOrder('.chapter')
    courseSectionOrder('.section')

  contentClick = ( content_button = '.add-content') ->
    $(content_button).click ->
      cs = $(@).data('cs-id')
      link = $(@)
      $("#cs-content-tab-#{cs}").toggle ->
        if $(@).is(':visible')
          link.html($('.cancel-text').html())
        else
          link.html($('.add-text').html())

  loadSyllabus =->
    $('#chapter-list').sortable(
        items: '.chapter',
        update: (e, ui) ->
          chapter_id = ui.item.data('chapter-id')
          version_id = $('#version_id').val()
          position = ui.item.index()
          console.log(chapter_id + version_id + position)

      )

    $('.section-list').sortable(
        items: '.section'
        connectWith: '.section-list, .content-listing'
        dropOnEmpty: true
        placeholder: 'sortable-placeholder'
        update: (e, ui) ->
          section_id = ui.item.data('section-id')
          section_id ||= ui.item.data('content-id')
          chapter_object = ui.item.parent().parent()
          chapter_id = chapter_object.data('chapter-id')
          version_id = $("#version_id").val()
          position = ui.item.index()
          console.log(section_id + chapter_object + chapter_id + version_id +position)
      )


    $('.content-listing').sortable(
      items: '.course-content'
      connectWith: '.content-listing'
      dropOnEmpty: true
      placeholder: 'content-listing sortable-placeholder'
      update: (e, ui) ->
        content_id = ui.item.data('content-id')
        content_id ||= ui.item.data('section-id')
        section_object = ui.item.parent().parent()
        movable = ui.item.data('movable')
        movable ||= (movable is undefined)
      )
  contentClick()
  resetLabelOrder()

  loadSyllabus()


