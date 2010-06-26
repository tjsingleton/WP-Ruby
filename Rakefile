require 'bundler'
Bundler.setup
Bundler.require :default

begin

  Bundler.require :test
  require 'rspec/core'
  require 'rspec/core/rake_task'

  desc "Run the code examples in spec"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "./spec/**/*_spec.rb"
  end

  desc "Run all examples with RCov"
  RSpec::Core::RakeTask.new('spec:rcov') do |t|
    t.pattern = "./spec/**/*_spec.rb"
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec']
  end

  task :default => :spec

rescue LoadError
  puts "RSpec require for testing."
end