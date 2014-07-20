class @Mascot

  constructor: (obj) ->
    for attr in ['school', 'name', 'tag']
      @[attr] = obj[attr]
    @['imageUrl'] = @generateImage()

  generateImage: ->
    fileBase = @underscore("#{@school}_#{@name}").toLowerCase()
    "assets/images/mascots/#{fileBase}.png"

  underscore: (str) ->
    str
      .replace(/['.]/g, '')
      .replace(/[^a-zA-Z0-9]+/g, '_')

  matches: (str) ->
    _(['school', 'name']).any (attr) =>
      regex = new RegExp(str, 'i')
      regex.test(@[attr])
