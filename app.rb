require './init'
require 'slim'
require 'sass'

get '/stylesheet.css' do
  # TODO Move site.sass out of views dir.
  sass :site
end

get '/:year?' do
  @year = (params[:year] || Year.latest).to_i
  @mascots = Mascot.all.fetch(@year, []).shuffle
  if @mascots.empty?
    slim :no_mascots
  else
    slim :index
  end
end
