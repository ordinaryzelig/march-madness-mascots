$ ->

  # Click a mascot, remove it from the list, add it to the ranks.
  $('.mascot').click (e) ->
    mascot = $(@)
    if !mascot.hasClass('ranked')
      mascot.fadeOut ->
        mascot.remove()
      $('#ranks').append("<li>#{mascot.attr('school')} #{mascot.attr('name')}</li>")

  # quicksearch.
  $('#search').quicksearch('#mascots li')

  # Hover over image, show enlarged image in tooltip.
  $('.tooltipHover').tooltip(effect: 'slide').dynamic(bottom: {direction: 'down', bounce: true})
