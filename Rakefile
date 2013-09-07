require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = 'spec/{unit,integration}/**/*_spec.rb'
  task.verbose = false
end

task default: :spec
