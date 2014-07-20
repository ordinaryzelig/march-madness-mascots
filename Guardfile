guard 'coffeescript', {
  :output => 'public/javascripts',
  :bare   => true
} do
  watch %r{public/coffee/(.+\.coffee)}
end

guard 'slim', {
  :slim => {
    :pretty => true,
  },
  :output_root => '.',
} do
  watch(%r'^.+\.slim$')
end
