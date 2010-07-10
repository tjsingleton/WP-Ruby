# DO NOT MODIFY THIS FILE
# Generated by Bundler 0.9.26

require 'digest/sha1'
require 'yaml'
require 'pathname'
require 'rubygems'
Gem.source_index # ensure Rubygems is fully loaded in Ruby 1.9

module Gem
  class Dependency
    if !instance_methods.map { |m| m.to_s }.include?("requirement")
      def requirement
        version_requirements
      end
    end
  end
end

module Bundler
  class Specification < Gem::Specification
    attr_accessor :relative_loaded_from

    def self.from_gemspec(gemspec)
      spec = allocate
      gemspec.instance_variables.each do |ivar|
        spec.instance_variable_set(ivar, gemspec.instance_variable_get(ivar))
      end
      spec
    end

    def loaded_from
      return super unless relative_loaded_from
      source.path.join(relative_loaded_from).to_s
    end

    def full_gem_path
      Pathname.new(loaded_from).dirname.expand_path.to_s
    end
  end

  module SharedHelpers
    attr_accessor :gem_loaded

    def default_gemfile
      gemfile = find_gemfile
      gemfile or raise GemfileNotFound, "Could not locate Gemfile"
      Pathname.new(gemfile)
    end

    def in_bundle?
      find_gemfile
    end

    def env_file
      default_gemfile.dirname.join(".bundle/environment.rb")
    end

  private

    def find_gemfile
      return ENV['BUNDLE_GEMFILE'] if ENV['BUNDLE_GEMFILE']

      previous = nil
      current  = File.expand_path(Dir.pwd)

      until !File.directory?(current) || current == previous
        filename = File.join(current, 'Gemfile')
        return filename if File.file?(filename)
        current, previous = File.expand_path("..", current), current
      end
    end

    def clean_load_path
      # handle 1.9 where system gems are always on the load path
      if defined?(::Gem)
        me = File.expand_path("../../", __FILE__)
        $LOAD_PATH.reject! do |p|
          next if File.expand_path(p).include?(me)
          p != File.dirname(__FILE__) &&
            Gem.path.any? { |gp| p.include?(gp) }
        end
        $LOAD_PATH.uniq!
      end
    end

    def reverse_rubygems_kernel_mixin
      # Disable rubygems' gem activation system
      ::Kernel.class_eval do
        if private_method_defined?(:gem_original_require)
          alias rubygems_require require
          alias require gem_original_require
        end

        undef gem
      end
    end

    def cripple_rubygems(specs)
      reverse_rubygems_kernel_mixin

      executables = specs.map { |s| s.executables }.flatten
      Gem.source_index # ensure RubyGems is fully loaded

     ::Kernel.class_eval do
        private
        def gem(*) ; end
      end

      ::Kernel.send(:define_method, :gem) do |dep, *reqs|
        if executables.include? File.basename(caller.first.split(':').first)
          return
        end
        opts = reqs.last.is_a?(Hash) ? reqs.pop : {}

        unless dep.respond_to?(:name) && dep.respond_to?(:requirement)
          dep = Gem::Dependency.new(dep, reqs)
        end

        spec = specs.find  { |s| s.name == dep.name }

        if spec.nil?
          e = Gem::LoadError.new "#{dep.name} is not part of the bundle. Add it to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        elsif dep !~ spec
          e = Gem::LoadError.new "can't activate #{dep}, already activated #{spec.full_name}. " \
                                 "Make sure all dependencies are added to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        end

        true
      end

      # === Following hacks are to improve on the generated bin wrappers ===

      # Yeah, talk about a hack
      source_index_class = (class << Gem::SourceIndex ; self ; end)
      source_index_class.send(:define_method, :from_gems_in) do |*args|
        source_index = Gem::SourceIndex.new
        source_index.spec_dirs = *args
        source_index.add_specs(*specs)
        source_index
      end

      # OMG more hacks
      gem_class = (class << Gem ; self ; end)
      gem_class.send(:define_method, :bin_path) do |name, *args|
        exec_name, *reqs = args

        spec = nil

        if exec_name
          spec = specs.find { |s| s.executables.include?(exec_name) }
          spec or raise Gem::Exception, "can't find executable #{exec_name}"
        else
          spec = specs.find  { |s| s.name == name }
          exec_name = spec.default_executable or raise Gem::Exception, "no default executable for #{spec.full_name}"
        end

        gem_bin = File.join(spec.full_gem_path, spec.bindir, exec_name)
        gem_from_path_bin = File.join(File.dirname(spec.loaded_from), spec.bindir, exec_name)
        File.exist?(gem_bin) ? gem_bin : gem_from_path_bin
      end
    end

    extend self
  end
end

module Bundler
  ENV_LOADED   = true
  LOCKED_BY    = '0.9.26'
  FINGERPRINT  = "8f632998df1d22f942460db37022bce3b9f5aef9"
  HOME         = '/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/bundler'
  AUTOREQUIRES = {:test=>[["capybara", false], ["cucumber", false], ["launchy", false], ["rspec", false]], :default=>[["data_mapper", false], ["dm-mysql-adapter", false], ["mysql2", false], ["php_serialize", false], ["ruby-debug19", false]]}
  SPECS        = [
        {:name=>"rake", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/rake-0.8.7/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/rake-0.8.7.gemspec"},
        {:name=>"addressable", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/addressable-2.1.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/addressable-2.1.2.gemspec"},
        {:name=>"archive-tar-minitar", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/archive-tar-minitar-0.5.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/archive-tar-minitar-0.5.2.gemspec"},
        {:name=>"builder", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/builder-2.1.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/builder-2.1.2.gemspec"},
        {:name=>"culerity", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/culerity-0.2.10/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/culerity-0.2.10.gemspec"},
        {:name=>"mime-types", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/mime-types-1.16/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/mime-types-1.16.gemspec"},
        {:name=>"nokogiri", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/nokogiri-1.4.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/nokogiri-1.4.2.gemspec"},
        {:name=>"rack", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/rack-1.2.1/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/rack-1.2.1.gemspec"},
        {:name=>"rack-test", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/rack-test-0.5.4/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/rack-test-0.5.4.gemspec"},
        {:name=>"ffi", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/ffi-0.6.3/lib", "/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/ffi-0.6.3/ext"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/ffi-0.6.3.gemspec"},
        {:name=>"json_pure", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/json_pure-1.4.3/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/json_pure-1.4.3.gemspec"},
        {:name=>"selenium-webdriver", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/selenium-webdriver-0.0.24/common/src/rb/lib", "/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/selenium-webdriver-0.0.24/firefox/src/rb/lib", "/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/selenium-webdriver-0.0.24/chrome/src/rb/lib", "/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/selenium-webdriver-0.0.24/jobbie/src/rb/lib", "/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/selenium-webdriver-0.0.24/remote/client/src/rb/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/selenium-webdriver-0.0.24.gemspec"},
        {:name=>"capybara", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/capybara-0.3.9/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/capybara-0.3.9.gemspec"},
        {:name=>"columnize", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/columnize-0.3.1/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/columnize-0.3.1.gemspec"},
        {:name=>"configuration", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/configuration-1.1.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/configuration-1.1.0.gemspec"},
        {:name=>"diff-lcs", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/diff-lcs-1.1.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/diff-lcs-1.1.2.gemspec"},
        {:name=>"trollop", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/trollop-1.16.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/trollop-1.16.2.gemspec"},
        {:name=>"gherkin", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/gherkin-2.0.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/gherkin-2.0.2.gemspec"},
        {:name=>"term-ansicolor", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/term-ansicolor-1.0.5/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/term-ansicolor-1.0.5.gemspec"},
        {:name=>"cucumber", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/cucumber-0.8.3/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/cucumber-0.8.3.gemspec"},
        {:name=>"extlib", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/extlib-0.9.15/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/extlib-0.9.15.gemspec"},
        {:name=>"dm-core", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-core-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-core-1.0.0.gemspec"},
        {:name=>"dm-aggregates", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-aggregates-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-aggregates-1.0.0.gemspec"},
        {:name=>"dm-migrations", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-migrations-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-migrations-1.0.0.gemspec"},
        {:name=>"dm-constraints", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-constraints-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-constraints-1.0.0.gemspec"},
        {:name=>"fastercsv", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/fastercsv-1.5.3/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/fastercsv-1.5.3.gemspec"},
        {:name=>"dm-serializer", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-serializer-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-serializer-1.0.0.gemspec"},
        {:name=>"dm-timestamps", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-timestamps-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-timestamps-1.0.0.gemspec"},
        {:name=>"dm-transactions", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-transactions-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-transactions-1.0.0.gemspec"},
        {:name=>"stringex", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/stringex-1.1.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/stringex-1.1.0.gemspec"},
        {:name=>"uuidtools", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/uuidtools-2.1.1/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/uuidtools-2.1.1.gemspec"},
        {:name=>"dm-types", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-types-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-types-1.0.0.gemspec"},
        {:name=>"dm-validations", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-validations-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-validations-1.0.0.gemspec"},
        {:name=>"data_mapper", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/data_mapper-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/data_mapper-1.0.0.gemspec"},
        {:name=>"data_objects", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/data_objects-0.10.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/data_objects-0.10.2.gemspec"},
        {:name=>"dm-do-adapter", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-do-adapter-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-do-adapter-1.0.0.gemspec"},
        {:name=>"do_mysql", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/do_mysql-0.10.2/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/do_mysql-0.10.2.gemspec"},
        {:name=>"dm-mysql-adapter", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/dm-mysql-adapter-1.0.0/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/dm-mysql-adapter-1.0.0.gemspec"},
        {:name=>"launchy", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/launchy-0.3.5/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/launchy-0.3.5.gemspec"},
        {:name=>"ruby_core_source", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/ruby_core_source-0.1.4/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/ruby_core_source-0.1.4.gemspec"},
        {:name=>"linecache19", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/linecache19-0.5.11/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/linecache19-0.5.11.gemspec"},
        {:name=>"mysql2", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/mysql2-0.1.8/lib", "/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/mysql2-0.1.8/ext"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/mysql2-0.1.8.gemspec"},
        {:name=>"php_serialize", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/php_serialize-1.1.3/lib/"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/php_serialize-1.1.3.gemspec"},
        {:name=>"rspec-core", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/rspec-core-2.0.0.beta.11/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/rspec-core-2.0.0.beta.11.gemspec"},
        {:name=>"rspec-expectations", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/rspec-expectations-2.0.0.beta.11/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/rspec-expectations-2.0.0.beta.11.gemspec"},
        {:name=>"rspec-mocks", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/rspec-mocks-2.0.0.beta.11/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/rspec-mocks-2.0.0.beta.11.gemspec"},
        {:name=>"rspec", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/rspec-2.0.0.beta.11/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/rspec-2.0.0.beta.11.gemspec"},
        {:name=>"ruby-debug-base19", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/ruby-debug-base19-0.11.23/lib"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/ruby-debug-base19-0.11.23.gemspec"},
        {:name=>"ruby-debug19", :load_paths=>["/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/gems/ruby-debug19-0.11.6/cli"], :loaded_from=>"/Users/tjsingleton/.rvm/gems/ruby-1.9.1-p378/specifications/ruby-debug19-0.11.6.gemspec"},
      ].map do |hash|
    if hash[:virtual_spec]
      spec = eval(hash[:virtual_spec], TOPLEVEL_BINDING, "<virtual spec for '#{hash[:name]}'>")
    else
      dir = File.dirname(hash[:loaded_from])
      spec = Dir.chdir(dir){ eval(File.read(hash[:loaded_from]), TOPLEVEL_BINDING, hash[:loaded_from]) }
    end
    spec.loaded_from = hash[:loaded_from]
    spec.require_paths = hash[:load_paths]
    if spec.loaded_from.include?(HOME)
      Bundler::Specification.from_gemspec(spec)
    else
      spec
    end
  end

  extend SharedHelpers

  def self.configure_gem_path_and_home(specs)
    # Fix paths, so that Gem.source_index and such will work
    paths = specs.map{|s| s.installation_path }
    paths.flatten!; paths.compact!; paths.uniq!; paths.reject!{|p| p.empty? }
    ENV['GEM_PATH'] = paths.join(File::PATH_SEPARATOR)
    ENV['GEM_HOME'] = paths.first
    Gem.clear_paths
  end

  def self.match_fingerprint
    lockfile = File.expand_path('../../Gemfile.lock', __FILE__)
    lock_print = YAML.load(File.read(lockfile))["hash"] if File.exist?(lockfile)
    gem_print = Digest::SHA1.hexdigest(File.read(File.expand_path('../../Gemfile', __FILE__)))

    unless gem_print == lock_print
      abort 'Gemfile changed since you last locked. Please run `bundle lock` to relock.'
    end

    unless gem_print == FINGERPRINT
      abort 'Your bundled environment is out of date. Run `bundle install` to regenerate it.'
    end
  end

  def self.setup(*groups)
    match_fingerprint
    clean_load_path
    cripple_rubygems(SPECS)
    configure_gem_path_and_home(SPECS)
    SPECS.each do |spec|
      Gem.loaded_specs[spec.name] = spec
      spec.require_paths.each do |path|
        $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
      end
    end
    self
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      (AUTOREQUIRES[group.to_sym] || []).each do |file, explicit|
        if explicit
          Kernel.require file
        else
          begin
            Kernel.require file
          rescue LoadError
          end
        end
      end
    end
  end

  # Set up load paths unless this file is being loaded after the Bundler gem
  setup unless defined?(Bundler::GEM_LOADED)
end
