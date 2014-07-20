
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
    return "images/mascots/" + fileBase + ".png";
  };

  Mascot.prototype.underscore = function(str) {
    return str.replace(/['.]/g, '').replace(/[^a-zA-Z0-9]+/g, '_');
  };

  Mascot.prototype.matches = function(str) {
    var _this = this;
    return _(['school', 'name']).any(function(attr) {
      var regex;
      regex = new RegExp(str, 'i');
      return regex.test(_this[attr]);
    });
  };

  return Mascot;

})();

angular.module('sure', ['ui.bootstrap']);

window.MascotsCtrl = function($scope, $http) {
  var checkedTags, defaultYear, includedByTag, includedByText, loadYear, tags, years;
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
  $scope.willShow = function(mascot) {
    return includedByTag(mascot.tag) && includedByText(mascot);
  };
  $scope.tooltip = function(mascot) {
    return '<img src="' + mascot.imageUrl + '">';
  };
  $scope.rankingInstructionsCollapsed = true;
  $scope.bracketInstructionsCollapsed = true;
  $scope.toggleCollapse = function(section) {
    return $scope["" + section + "Collapsed"] = !$scope["" + section + "Collapsed"];
  };
  includedByTag = function(tag) {
    var checked, noneChecked, tagIsChecked;
    checked = checkedTags();
    noneChecked = checked.length === 0;
    if (noneChecked) return true;
    return tagIsChecked = _(checked).include(tag);
  };
  includedByText = function(mascot) {
    var textExists;
    textExists = ($scope.filterText != null) && $scope.filterText !== '';
    if (!textExists) return true;
    return mascot.matches($scope.filterText);
  };
  loadYear = function() {
    $scope.mascots = $scope.data[$scope.year];
    window.mascots = $scope.mascots;
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
