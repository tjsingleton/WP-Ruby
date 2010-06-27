class WP::Commentmeta
  include DataMapper::Resource
  storage_names[:default] = "wp_commentmeta"

  property :meta_id, Serial
  property :comment_id, Integer
  property :meta_key, String
  property :meta_value, Text

  belongs_to :comment
end