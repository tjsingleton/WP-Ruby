$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'wp-ruby'
require 'rspec'
require "mysql2"

MYSQL_CONNECTION = Mysql2::Client.new({
  :host => "localhost",
  :username => "root",
  :database => "wordpress_test"
})


TABLES = %w[wp_commentmeta wp_comments wp_links wp_options wp_postmeta wp_posts wp_term_relationships wp_term_taxonomy wp_terms wp_usermeta wp_users]
INSERTS = File.open("spec/inserts.sql").to_a

RSpec.configure do |config|
  config.before(:each) do
    TABLES.each {|table| MYSQL_CONNECTION.query("TRUNCATE TABLE #{table};") }
    INSERTS.each {|line| MYSQL_CONNECTION.query(line) }
  end
end