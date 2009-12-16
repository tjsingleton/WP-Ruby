class WP::Link
  include DataMapper::Resource

  property :link_id, Serial
  property :link_url, String
  property :link_name, String
  property :link_image, String
  property :link_target, String
  property :link_description, String
  property :link_visible, String
  property :link_owner, Integer
  property :link_rating, Integer
  property :link_updated, DateTime
  property :link_rel, String
  property :link_notes, Text
  property :link_rss, String

  belongs_to :user, :child_key => :link_owner
end