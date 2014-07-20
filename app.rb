require './init'
require 'slim'
require 'sass'

Slim::Engine.default_options[:pretty] = true

get '/stylesheet.css' do
  # TODO Move site.sass out of views dir.
  sass :site
end

get '/*' do
  slim :index
end
