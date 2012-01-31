
$(function() {
  $('.mascot').click(function(e) {
    var mascot;
    mascot = $(this);
    if (!mascot.hasClass('ranked')) {
      mascot.fadeOut(function() {
        return mascot.remove();
      });
      return $('#ranks').append("<li>" + (mascot.attr('school')) + " " + (mascot.attr('name')) + "</li>");
    }
  });
  $('#search').quicksearch('#mascots li');
  return $('.tooltipHover').tooltip({
    effect: 'slide'
  }).dynamic({
    bottom: {
      direction: 'down',
      bounce: true
    }
  });
});
