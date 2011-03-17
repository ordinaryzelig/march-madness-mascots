// Click a mascot, remove it from the list, add it to the ranks.
function rankMascots() {
  $('.mascot').click(function(e) {
    var mascot = $(this)
    if (!mascot.hasClass('ranked')) {
      mascot.fadeOut(function() { mascot.remove() })
      $('#ranks').append("<li>" + mascot.attr('school') + " " + mascot.attr('name') + "</li>")
    }
  })
}

$(function() {

  // quicksearch.
  $('#search').quicksearch('#mascots li')

  $('.tooltipHover').tooltip({effect: 'slide'}).dynamic({ bottom: { direction: 'down', bounce: true } })

})
