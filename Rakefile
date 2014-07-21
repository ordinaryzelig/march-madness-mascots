require 'rake/testtask'

task :default => 'mascots:compile'

task :init do
  require_relative 'init'
end

namespace :mascots do

  desc 'Convert CSVs into runnable JS.'
  task :compile => :init do
    puts 'compiling'
    Mascot.compile_all!
    puts 'done'
  end

end
