class WP::Sitemeta
  include DataMapper::Resource
  storage_names[:default] = "wp_usermeta"

  property :meta_id, Serial
  property :site_id, Integer
  property :meta_key, String
  property :meta_value, Text

end