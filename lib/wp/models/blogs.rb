class WP::Blog
  include DataMapper::Resource

  property :blog_id, Serial
  property :site_id, Integer
  property :domain, String
  property :path, String
  property :registered, DateTime
  property :last_updated, DateTime
  property :public, Integer
  property :archived, Enum[0, 1]
  property :mature, Integer
  property :spam, Integer
  property :deleted, Integer
  property :lang_id, Integer

end