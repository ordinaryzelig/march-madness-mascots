require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.libs << 'spec'
  t.pattern = 'spec/**/*.spec.rb'
end

task :init do
  require_relative 'init'
end

namespace :mascots do

  desc 'Convert CSVs into runnable JS.'
  task :compile => :init do
    Mascot.compile_all!
  end

end
