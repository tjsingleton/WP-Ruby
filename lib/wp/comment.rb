class WP::Comment
  include DataMapper::Resource

  property :comment_ID, Serial
  property :comment_post_ID, Integer
  property :comment_author, Text
  property :comment_author_email, String
  property :comment_author_url, String
  property :comment_author_IP, String
  property :comment_date, DateTime
  property :comment_date_gmt, DateTime
  property :comment_content, Text
  property :comment_karma, Integer
  property :comment_approved, String
  property :comment_agent, String
  property :comment_type, String
  property :comment_parent, Integer
  property :user_id, Integer

  belongs_to :post, :child_key => :comment_post_ID
  belongs_to :user, :child_key => :user_id
  # parent
end