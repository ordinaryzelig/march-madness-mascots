class @Mascot

  constructor: (obj) ->
    for attr in ['school', 'name', 'tag']
      @[attr] = obj[attr]
    @['imageUrl'] = @generateImage()

  generateImage: ->
    fileBase = @underscore("#{@school}_#{@name}").toLowerCase()
    "images/mascots/#{fileBase}.png"

  underscore: (str) ->
    str
      .replace(/['.]/g, '')
      .replace(/[^a-zA-Z0-9]+/g, '_')

  matches: (str) ->
    _(['school', 'name']).any (attr) =>
      regex = new RegExp(str, 'i')
      regex.test(@[attr])

angular.module('sure', ['ui.bootstrap'])
window.MascotsCtrl = ($scope, $http) ->

  # Load remote data.
  $http(url: 'javascripts/data.json')
    .success (data) ->
      # Map data as Mascot objects.
      $scope.data = {}
      _(Object.keys(data)).each (year) ->
        mascots = _(data[year]).map (obj) ->
          new Mascot(obj)
        $scope.data[year] = mascots
      window.data = $scope.data

      $scope.year        = defaultYear() unless $scope.year?
      $scope.yearOptions = _(years()).reverse()

      loadYear()

  $scope.changeYear = ->
    loadYear()

  $scope.willShow = (mascot) ->
    includedByTag(mascot.tag) and includedByText(mascot)

  $scope.tooltip = (mascot) ->
    '<img src="' + mascot.imageUrl + '">'

  $scope.pick = (mascot) ->
    remove(mascot)
    rank(mascot)

  remove = (mascot) ->
    index = $scope.mascots.indexOf(mascot)
    $scope.mascots.splice(index, 1)

  rank = (mascot) ->
    $scope.ranks.push mascot

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
    $scope.mascots = $scope.data[$scope.year]
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
