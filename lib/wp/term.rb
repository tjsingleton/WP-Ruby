class WP::Term
  include DataMapper::Resource

  property :term_id, Serial
  property :name, String
  property :slug, String
  property :term_group, Integer

  has n, :term_taxonomies, :child_key => :term_id
end