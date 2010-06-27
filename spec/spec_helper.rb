$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'wp-ruby'
require 'rspec'
require "mysql2"

INITIAL_SQL = File.open("spec/wordpress_test_2010-06-27.sql").to_a

MYSQL_CONNECTION = Mysql2::Client.new({
  :host => "localhost",
  :username => "root",
  :database => "wordpress_test"
})

RSpec.configure do |config|
  config.before(:each) do
    INITIAL_SQL.each {|line| MYSQL_CONNECTION.query(line) }
  end
end