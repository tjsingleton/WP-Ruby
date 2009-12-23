class WP::BlogVersion
  include DataMapper::Resource

  property :blog_id, Integer
  property :db_version, String
  property :last_updated, DateTime
end