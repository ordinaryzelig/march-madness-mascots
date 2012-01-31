
$(function() {
  $('.mascot').click(function() {
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
  $('.tooltipHover').tooltip({
    effect: 'slide'
  }).dynamic({
    bottom: {
      direction: 'down',
      bounce: true
    }
  });
  return $('#tags input').click(function() {
    var checkbox, checked, mascots, tags;
    mascots = $('.mascot');
    checked = $('#tags input:checked');
    if (checked.length) {
      tags = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = checked.length; _i < _len; _i++) {
          checkbox = checked[_i];
          _results.push($(checkbox).data('name'));
        }
        return _results;
      })();
      return mascots.each(function() {
        var hasTag, mascot, tag, _i, _len;
        mascot = $(this);
        hasTag = false;
        for (_i = 0, _len = tags.length; _i < _len; _i++) {
          tag = tags[_i];
          if (mascot.hasClass(tag)) {
            hasTag = true;
            break;
          }
        }
        if (hasTag) {
          return mascot.show();
        } else {
          return mascot.hide();
        }
      });
    } else {
      return mascots.show();
    }
  });
});
