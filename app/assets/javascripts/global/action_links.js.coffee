root = this
root.filterPanel = false

root.initSlideDownPanel = ->
  $('body').click (event) ->
    withinPanel = event.target.id == 'slide-down-panel' || $(event.target).parents('#slide-down-panel').length > 0
    if root.filterPanel && !withinPanel
      root.hideFilterPanel()
  return

root.showFilterPanel = ->
  $('#slide-down-panel').animate({'margin-top': '0px'})
  $('#overlay').show()
  setTimeout ( ->
    root.filterPanel = true
    $('input.slider').slider()
  ), 300
  return

root.hideFilterPanel = ->
  panel = $('#slide-down-panel')
  animeMargin = ( panel.outerHeight() + 20 ) * -1
  panel.animate({'margin-top': animeMargin})
  $('#overlay').hide()
  root.filterPanel = false
  return

$(document).ready ->
  root.initSlideDownPanel()
