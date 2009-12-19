require 'rubygems'
require 'rake'
require 'yard'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "wp-ruby"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "tjsingleton@vantagestreet.com"
    gem.homepage = "http://github.com/tjsingleton/wp-ruby"
    gem.authors = ["TJ Singleton"]
    gem.add_dependency "php-serialize"
    gem.add_dependency "dm-core"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "yard"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

YARD::Rake::YardocTask.new do |yard|
  yard.files << ('README*')
  yard.files << ('lib/**/*.rb')
end
