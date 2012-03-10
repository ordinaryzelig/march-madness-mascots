$ ->

  # ==========================================================
  # Click a mascot, remove it from the list, add it to the ranks.
  $('.mascot').click ->
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
  $('.tooltipHover').tooltip(effect: 'slide').dynamic(bottom: {direction: 'down', bounce: true})

  # ==========================================================
  # Filter checkboxes.
  # When clicked, show only mascots with matching tag.
  $('#tags input').click ->
    mascots = $('.mascot')
    checked = $('#tags input:checked')
    # If there are any checked tags, loop through mascots, show if mascot has class matching any checked tag.
    if checked.length
      tags = ($(checkbox).data('name') for checkbox in checked)
      mascots.each ->
        mascot = $(@)
        hasTag = false
        for tag in tags
          if mascot.hasClass(tag)
            hasTag = true
            break
        if hasTag
           mascot.show()
        else
          mascot.hide()
    else
      # Nothing checked, show all.
      mascots.show()

  # ==========================================================
  # Toggle instructions.

  toggleInstructionsOnClick = (section) ->
    $("a.#{section}").click -> $("ul.#{section}").slideToggle()

  for section in ['howRank', 'howBracket']
    toggleInstructionsOnClick(section)

  # ==========================================================
  # Year select.

  $('#yearSelect').change ->
    year = $(@).val()
    window.location.replace("/#{year}")
