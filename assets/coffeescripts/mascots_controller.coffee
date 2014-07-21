angular.module('sure', ['ui.bootstrap'])
window.MascotsCtrl = ($scope) ->

  loadData = ->
    # Map data as Mascot objects.
    $scope.data = {}
    _(Object.keys(data)).each (year) ->
      mascots = _(data[year]).map (obj) ->
        new Mascot(obj)
      $scope.data[year] = mascots

  init = ->
    loadData()
    $scope.year        = defaultYear() unless $scope.year?
    $scope.yearOptions = _(years()).reverse()
    loadYear()

  $scope.changeYear = ->
    loadYear()

  $scope.willShow = (mascot) ->
    includedByTag(mascot.tag) and includedByText(mascot)

  $scope.tooltip = (mascot) ->
    '<img src="' + mascot.imageUrl + '" class="img-responsive">'

  #########
  # Picking

  $scope.pick = (mascot) ->
    remove(mascot)
    rank(mascot)

  $scope.unpick = (mascot) ->
    unrank(mascot)
    reAdd(mascot)

  remove = (mascot) ->
    index = $scope.mascots.indexOf(mascot)
    $scope.mascots.splice(index, 1)

  rank = (mascot) ->
    $scope.ranks.push mascot

  reAdd = (mascot) ->
    $scope.mascots.push(mascot)

  unrank = (mascot) ->
    index = $scope.ranks.indexOf(mascot)
    $scope.ranks.splice(index, 1)

  #########

  # Toggle instructions
  $scope.rankingInstructionsCollapsed = true
  $scope.bracketInstructionsCollapsed = true
  $scope.toggleCollapse = (section) ->
    $scope["#{section}Collapsed"] = !$scope["#{section}Collapsed"]

  includedByTag = (tag) ->
    checked = checkedTags()
    noneChecked = checked.length == 0
    return true if noneChecked
    tagIsChecked = _(checked).include(tag)

  includedByText = (mascot) ->
    textExists = $scope.filterText? and $scope.filterText != ''
    return true unless textExists
    mascot.matches($scope.filterText)

  loadYear = ->
    $scope.mascots = _($scope.data[$scope.year]).shuffle()
    window.mascots = $scope.mascots
    $scope.tags    = tags()
    $scope.ranks   = []

  defaultYear = ->
    _(years()).last()

  years = ->
    Object.keys($scope.data)

  # Construct hash of tag and checked boolean.
  tags = ->
    window.tags = _($scope.data[$scope.year])
      .reduce(
        ((hash, mascot) ->
          hash[mascot.tag] = false
          hash
        ), {}
      )

  checkedTags = ->
    _($scope.tags).reduce(
      ((array, checked, tag) ->
        array.push tag if checked
        array
      ), []
    )

  init()
