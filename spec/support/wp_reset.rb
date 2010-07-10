class WP_Reset
  MYSQL_CONNECTION = Mysql2::Client.new({
    :host => "localhost",
    :username => "root",
    :database => "wordpress_test"
  })


  TABLES = %w[wp_commentmeta wp_comments wp_links wp_options wp_postmeta wp_posts
              wp_term_relationships wp_term_taxonomy wp_terms wp_usermeta wp_users]
  INSERTS = File.open("spec/fixtures/inserts.sql").to_a

  def self.clear_tables
    TABLES.each {|table| MYSQL_CONNECTION.query("TRUNCATE TABLE #{table};") }
  end

  def self.install_default_data
    INSERTS.each {|line| MYSQL_CONNECTION.query(line) }
  end
end