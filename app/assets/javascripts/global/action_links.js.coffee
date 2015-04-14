root = this
root.filterPanel = false

root.initSlideDownPanel = ->
  $('body').click (event) ->
    withinPanel = $(event.target).hasClass('slide-down-panel') || $(event.target).parents('.slide-down-panel').length > 0
    if root.filterPanel && !withinPanel
      root.hidePanel()
  return

root.showPanel = (id) ->
  root.panelId = id
  $(id + '.slide-down-panel').animate({'margin-top': '0px'})
  $('#overlay').show()
  setTimeout ( ->
    root.filterPanel = true
    $('input.slider').slider()
    google.maps.event.trigger($("#events-map")[0], 'resize')
  ), 300
  return

root.hidePanel = ->
  panel = $(root.panelId + '.slide-down-panel')
  animeMargin = ( panel.outerHeight() + 20 ) * -1
  panel.animate({'margin-top': animeMargin})
  $('#overlay').hide()
  root.filterPanel = false
  return

$(document).ready ->
  root.initSlideDownPanel()
