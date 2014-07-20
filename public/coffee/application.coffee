#$ ->

  ## ==========================================================
  ## Click a mascot, remove it from the list, add it to the ranks.
  #$('.mascot').on 'click', ->
    #mascot = $(@)
    #if !mascot.hasClass('ranked')
      #mascot.fadeOut ->
        #mascot.remove()
      #$('#ranks').append("<li>#{mascot.data('school')} #{mascot.data('name')}</li>")

  ## ==========================================================
  ## Toggle instructions.

  #toggleInstructionsOnClick = (section) ->
    #$("a.#{section}").click -> $("ul.#{section}").slideToggle()

  #for section in ['howRank', 'howBracket']
    #toggleInstructionsOnClick(section)
