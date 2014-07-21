angular.module('sure', ['ui.bootstrap']);

window.MascotsCtrl = function($scope) {
  var checkedTags, defaultYear, includedByTag, includedByText, init, loadData, loadYear, rank, remove, tags, years;
  loadData = function() {
    $scope.data = {};
    return _(Object.keys(data)).each(function(year) {
      var mascots;
      mascots = _(data[year]).map(function(obj) {
        return new Mascot(obj);
      });
      return $scope.data[year] = mascots;
    });
  };
  init = function() {
    loadData();
    if ($scope.year == null) {
      $scope.year = defaultYear();
    }
    $scope.yearOptions = _(years()).reverse();
    return loadYear();
  };
  $scope.changeYear = function() {
    return loadYear();
  };
  $scope.willShow = function(mascot) {
    return includedByTag(mascot.tag) && includedByText(mascot);
  };
  $scope.tooltip = function(mascot) {
    return '<img src="' + mascot.imageUrl + '" class="img-responsive">';
  };
  $scope.pick = function(mascot) {
    remove(mascot);
    return rank(mascot);
  };
  remove = function(mascot) {
    var index;
    index = $scope.mascots.indexOf(mascot);
    return $scope.mascots.splice(index, 1);
  };
  rank = function(mascot) {
    return $scope.ranks.push(mascot);
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
    if (noneChecked) {
      return true;
    }
    return tagIsChecked = _(checked).include(tag);
  };
  includedByText = function(mascot) {
    var textExists;
    textExists = ($scope.filterText != null) && $scope.filterText !== '';
    if (!textExists) {
      return true;
    }
    return mascot.matches($scope.filterText);
  };
  loadYear = function() {
    $scope.mascots = $scope.data[$scope.year];
    window.mascots = $scope.mascots;
    $scope.tags = tags();
    return $scope.ranks = [];
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
  checkedTags = function() {
    return _($scope.tags).reduce((function(array, checked, tag) {
      if (checked) {
        array.push(tag);
      }
      return array;
    }), []);
  };
  return init();
};
