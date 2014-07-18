$ ->

  # ==========================================================
  # Click a mascot, remove it from the list, add it to the ranks.
  $('.mascot').on 'click', ->
    mascot = $(@)
    if !mascot.hasClass('ranked')
      mascot.fadeOut ->
        mascot.remove()
      $('#ranks').append("<li>#{mascot.data('school')} #{mascot.data('name')}</li>")

  # ==========================================================
  # quicksearch.
  $('#search').quicksearch('#mascots li')

  # ==========================================================
  # Hover over image, show enlarged image in tooltip.
  #$('.tooltipHover').tooltip(effect: 'slide').dynamic(bottom: {direction: 'down', bounce: true})

  # ==========================================================
  # Toggle instructions.

  toggleInstructionsOnClick = (section) ->
    $("a.#{section}").click -> $("ul.#{section}").slideToggle()

  for section in ['howRank', 'howBracket']
    toggleInstructionsOnClick(section)
