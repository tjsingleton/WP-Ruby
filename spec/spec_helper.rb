$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'wp-ruby'
require 'rspec'
require "mysql2"
require "support/wp_reset.rb"


RSpec.configure do |config|
  config.before(:each) do
    WP_Reset.clear_tables
    WP_Reset.install_default_data
  end
end