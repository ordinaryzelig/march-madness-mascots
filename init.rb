ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

# Require lib files.
Dir['./lib/*'].each { |f| require f }

# Require models.
Dir['./models/*'].each { |f| require f }
