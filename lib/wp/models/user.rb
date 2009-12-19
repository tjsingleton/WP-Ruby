class WP::User
  include DataMapper::Resource

  property :ID, Serial
  property :user_login, String
  property :user_pass, String
  property :user_nicename, String
  property :user_url, String
  property :user_registered, DateTime
  property :user_activation_key, String
  property :user_status, Integer
  property :display_name, String

  has n, :posts, :child_key => :post_author
  has n, :comments
  has n, :usermeta
end