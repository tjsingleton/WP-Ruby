class WP::Site
  include DataMapper::Resource
  storage_names[:default] = "wp_site"

  property :id, Integer
  property :domain, String
  property :path, String

end