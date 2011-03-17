require './support'
require './mascot'
require 'slim'
require 'sass'

get '/' do
  @mascots = Mascot.all.shuffle
  slim :index
end

get '/stylesheet.css' do
  sass :site
end
