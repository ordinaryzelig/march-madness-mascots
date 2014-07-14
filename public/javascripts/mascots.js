
this.Mascot = (function() {
  var underscore;

  function Mascot(obj) {
    var attr, _i, _len, _ref;
    _ref = ['school', 'name', 'tag'];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      attr = _ref[_i];
      this[attr] = obj[attr];
    }
    this['image_url'] = this.generateImage();
  }

  Mascot.prototype.generateImage = function() {
    var fileBase;
    fileBase = underscore("" + this.school + "_" + this.name).toLowerCase();
    return "images/mascots/" + fileBase + ".png";
  };

  underscore = function(str) {
    return str.replace("'", '').replace(/[^a-zA-Z]+/g, '_');
  };

  return Mascot;

})();

window.MascotsCtrl = function($scope, $http) {
  return $http({
    url: 'javascripts/data.json'
  }).success(function(data) {
    return $scope.mascots = _(data['2014']).map(function(obj) {
      return new Mascot(obj);
    });
  });
};
