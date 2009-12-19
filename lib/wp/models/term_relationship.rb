class WP::TermRelationship
  include DataMapper::Resource

  property :object_id, Serial
  property :term_taxonomy_id, Integer
  property :term_order, Integer

  # object
  belongs_to :term_taxonomy, :child_key => :term_taxonomy_id
end