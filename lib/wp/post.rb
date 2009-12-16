class WP::Post
  include DataMapper::Resource

  property :ID, Serial
  property :post_author, Integer
  property :post_date, DateTime
  property :post_date_gmt, DateTime
  property :post_content, Text
  property :post_title, Text
  property :post_excerpt, Text
  property :post_status, String
  property :comment_status, String
  property :ping_status, String
  property :post_password, String
  property :post_name, String
  property :to_ping, Text
  property :pinged, Text
  property :post_modified, DateTime
  property :post_modified_gmt, DateTime
  property :post_content_filtered, Text
  property :post_parent, Integer
  property :guid, String
  property :menu_order, Integer
  property :post_type, String
  property :post_mime_type, String
  property :comment_count, Integer

  belongs_to :user, :child_key => :post_author
  has n, :comments, :child_key => :comment_post_ID
  has n, :postmeta
  # parent
end