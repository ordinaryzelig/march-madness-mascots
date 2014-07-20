this.Mascot = (function() {
  function Mascot(obj) {
    var attr, _i, _len, _ref;
    _ref = ['school', 'name', 'tag'];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      attr = _ref[_i];
      this[attr] = obj[attr];
    }
    this['imageUrl'] = this.generateImage();
  }

  Mascot.prototype.generateImage = function() {
    var fileBase;
    fileBase = this.underscore("" + this.school + "_" + this.name).toLowerCase();
    return "assets/images/mascots/" + fileBase + ".png";
  };

  Mascot.prototype.underscore = function(str) {
    return str.replace(/['.]/g, '').replace(/[^a-zA-Z0-9]+/g, '_');
  };

  Mascot.prototype.matches = function(str) {
    return _(['school', 'name']).any((function(_this) {
      return function(attr) {
        var regex;
        regex = new RegExp(str, 'i');
        return regex.test(_this[attr]);
      };
    })(this));
  };

  return Mascot;

})();
