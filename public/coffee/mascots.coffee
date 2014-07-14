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
      .replace(/['.]/g, '') # Remove apostrophes
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

      # Set options.
      $scope.yearOptions = _(years()).reverse()

      loadYear()

  $scope.changeYear = ->
    loadYear()

  loadYear = ->
    $scope.year = defaultYear() unless $scope.year?
    $scope.mascots = $scope.data[$scope.year]

  defaultYear = ->
    _(years()).last()

  years = ->
    Object.keys($scope.data)
