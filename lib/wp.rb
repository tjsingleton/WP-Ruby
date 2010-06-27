require "bundler"
Bundler.setup
require "dm-core"
require "php_serialize"

require 'pathname'

module WP
  extend self
  ROOT = Pathname.pwd.join("lib", "wp")

  def init
    setup_datamapper
    load_files
  end

  def setup_datamapper
    DataMapper.setup(:default, 'mysql://localhost/wordpress_test')
  end

  def load_files
    files_to_load.each{|model| require model }
  end

  def files_to_load
    [ROOT.join("models").children, ROOT.join("utility")].flatten
  end
end