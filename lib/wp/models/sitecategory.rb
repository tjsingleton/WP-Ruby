class WP::Sitecategory
  include DataMapper::Resource

  property :cat_ID, Serial
  property :cat_name, String
  property :category_nicename, String
  property :last_updated, EpochTime
  
end