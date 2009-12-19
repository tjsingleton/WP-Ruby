require 'dm-core'
require "pathname"

module WP
  extend self
  ROOT = Pathname.pwd

  def init
    setup_datamapper
    load_models
  end

  def setup_datamapper
    DataMapper.setup(:default, 'mysql://localhost/wordpress')
  end

  def load_models
    ROOT.join("lib", "wp").children.each{|model| require model }
  end
end