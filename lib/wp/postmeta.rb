class WP::Postmeta
  include DataMapper::Resource
  storage_names[:default] = "wp_postmeta"

  property :meta_id, Serial
  property :post_id, Integer
  property :meta_key, String
  property :meta_value, Text

  belongs_to :post
end