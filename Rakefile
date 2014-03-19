require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

# If you want to make this the default task
task default: :spec

desc 'load gem files into IRB'
task :console do
  exec 'irb -Ilib -rbail'
  # exec 'irb -I lib -r startingscript.rb'
end
