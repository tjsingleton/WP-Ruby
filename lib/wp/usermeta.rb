class WP::Usermeta
  include DataMapper::Resource
  storage_names[:default] = "wp_usermeta"

  property :umeta_id, Serial
  property :user_id, Integer
  property :meta_key, String
  property :meta_value, Text

  belongs_to :user
end