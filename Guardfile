guard 'coffeescript', {
  :output => 'assets/javascripts',
  :bare   => true
} do
  watch %r{assets/coffeescripts/(.+\.coffee)}
end

guard 'slim', {
  :slim => {
    :pretty => true,
  },
  :output_root => '.',
} do
  watch(%r'^.+\.slim$')
end

guard 'sass', :input => 'sass', :output => 'assets/stylesheets' do
  watch(%r{assets/stylesheets/(.+\.sass)})
end
