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
      .replace("'", '') # Remove apostrophes
      .replace(/[^a-zA-Z]+/g, '_')

window.MascotsCtrl = ($scope, $http) ->
  $http(url: 'javascripts/data.json')
    .success (data) ->
      $scope.mascots = _(data['2014']).map (obj) ->
        new Mascot(obj)
