require './init'
require 'slim'
require 'sass'

get '/stylesheet.css' do
  # TODO Move site.sass out of views dir.
  sass :site
end

get '/:year?' do
  @year = (params[:year] || Year.latest).to_i
  slim :index
end
