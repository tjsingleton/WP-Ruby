$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "rubygems"
require "bundler"
Bundler.setup
require 'rspec'
require 'wp-ruby'

require "mysql"

INITIAL_SQL = File.open("spec/wordpress_test_2010-06-27.sql").to_a

MYSQL_CONNECTION = Mysql.new("localhost", "root", "", "wordpress_test")

RSpec.configure do |config|
  config.before(:each) do
    INITIAL_SQL.each {|line| MYSQL_CONNECTION.query(line) }
  end
end