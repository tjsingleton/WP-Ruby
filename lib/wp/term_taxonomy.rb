class WP::TermTaxonomy
  include DataMapper::Resource
  storage_names[:default] = "wp_term_taxonomy"

  property :term_taxonomy_id, Serial
  property :term_id, Integer
  property :taxonomy, String
  property :description, Text
  property :parent, Integer
  property :count, Integer

  belongs_to :term, :child_key => :term_id
  # parent
end