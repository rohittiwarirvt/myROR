$ ->
  courseSectionOrder = (item) ->
    $(item).each ->
      index = $(@).index()
      #label =

  window.contentClick = ( content_button = '.add-content') ->
    $(content_button).click ->
      cs = $(@).data('cs-id')
      link = $(@)
      $("#cs-content-tab-#{cs}").toggle ->
        if $(@).is(':visible')
          link.html($('.cancel-text').html())
        else
          link.html($('.add-text').html())
  contentClick()


