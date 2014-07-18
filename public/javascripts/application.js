
$(function() {
  var section, toggleInstructionsOnClick, _i, _len, _ref, _results;
  $('.mascot').on('click', function() {
    var mascot;
    mascot = $(this);
    if (!mascot.hasClass('ranked')) {
      mascot.fadeOut(function() {
        return mascot.remove();
      });
      return $('#ranks').append("<li>" + (mascot.data('school')) + " " + (mascot.data('name')) + "</li>");
    }
  });
  $('#search').quicksearch('#mascots li');
  toggleInstructionsOnClick = function(section) {
    return $("a." + section).click(function() {
      return $("ul." + section).slideToggle();
    });
  };
  _ref = ['howRank', 'howBracket'];
  _results = [];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    section = _ref[_i];
    _results.push(toggleInstructionsOnClick(section));
  }
  return _results;
});
