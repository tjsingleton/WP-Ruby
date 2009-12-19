class WP::Option
  include DataMapper::Resource

  property :option_id, Serial
  property :blog_id, Integer
  property :option_name, String
  property :option_value, Text
  property :autoload, String
end