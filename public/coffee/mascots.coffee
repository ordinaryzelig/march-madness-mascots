class @Mascot

  constructor: (obj) ->
    for attr in ['school', 'name', 'tag']
      @[attr] = obj[attr]
    @['image_url'] = @generateImage()

  generateImage: ->
    fileBase = underscore("#{@school}_#{@name}").toLowerCase()
    "images/mascots/#{fileBase}.png"

  underscore = (str) ->
    str
      .replace(/['.]/g, '')
      .replace(/[^a-zA-Z0-9]+/g, '_')

window.MascotsCtrl = ($scope, $http, $location) ->

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

  $scope.willHide = (tag) ->
    checked = checkedTags()
    noneChecked = checked.length == 0
    return false if noneChecked
    tagChecked = _(checked).indexOf(tag) != -1
    !tagChecked

  loadYear = ->
    $scope.mascots = $scope.data[$scope.year]
    $scope.tags    = tags()

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
