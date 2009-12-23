class WP::Signup
  include DataMapper::Resource

  property :domain, String
  property :path, String
  property :title, Text
  property :user_login, String
  property :user_email, String
  property :registerd, DateTime
  property :activated, DateTime
  property :active, Integer
  property :activation_key, String
  property :meta, Text

end