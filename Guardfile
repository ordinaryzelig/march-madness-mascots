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
