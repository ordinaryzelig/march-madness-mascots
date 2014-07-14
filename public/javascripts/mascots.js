
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
    return str.replace(/['.]/g, '').replace(/[^a-zA-Z0-9]+/g, '_');
  };

  return Mascot;

})();

window.MascotsCtrl = function($scope, $http, $location) {
  var defaultYear, loadYear, years;
  $http({
    url: 'javascripts/data.json'
  }).success(function(data) {
    $scope.data = {};
    _(Object.keys(data)).each(function(year) {
      var mascots;
      mascots = _(data[year]).map(function(obj) {
        return new Mascot(obj);
      });
      return $scope.data[year] = mascots;
    });
    $scope.yearOptions = _(years()).reverse();
    return loadYear();
  });
  $scope.changeYear = function() {
    return loadYear();
  };
  loadYear = function() {
    if ($scope.year == null) $scope.year = defaultYear();
    return $scope.mascots = $scope.data[$scope.year];
  };
  defaultYear = function() {
    return _(years()).last();
  };
  return years = function() {
    return Object.keys($scope.data);
  };
};
