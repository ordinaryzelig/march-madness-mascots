
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
  var checkedTags, defaultYear, loadYear, tags, years;
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
    window.data = $scope.data;
    if ($scope.year == null) $scope.year = defaultYear();
    $scope.yearOptions = _(years()).reverse();
    return loadYear();
  });
  $scope.changeYear = function() {
    return loadYear();
  };
  $scope.willHide = function(tag) {
    var checked, noneChecked, tagChecked;
    checked = checkedTags();
    noneChecked = checked.length === 0;
    if (noneChecked) return false;
    tagChecked = _(checked).indexOf(tag) !== -1;
    return !tagChecked;
  };
  loadYear = function() {
    $scope.mascots = $scope.data[$scope.year];
    return $scope.tags = tags();
  };
  defaultYear = function() {
    return _(years()).last();
  };
  years = function() {
    return Object.keys($scope.data);
  };
  tags = function() {
    return window.tags = _($scope.data[$scope.year]).reduce((function(hash, mascot) {
      hash[mascot.tag] = false;
      return hash;
    }), {});
  };
  return checkedTags = function() {
    return _($scope.tags).reduce((function(array, checked, tag) {
      if (checked) array.push(tag);
      return array;
    }), []);
  };
};
