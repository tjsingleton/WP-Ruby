class WP::Option
  include DataMapper::Resource

  property :option_id, Serial
  property :blog_id, Integer
  property :option_name, String
  property :option_value, Text
  property :autoload, String

  class << self
    def find_by_name(name)
      self.first :option_name => name
    end

    def [](name)
      find_by_name(name).value || self.new(:option_name => name)
    end

    def []=(name, value)
      find_by_name(name).update_attributes(:option_value => value) || begin
        option = self.new
        # FIXME how to handle blog id?
        option.update_attributes(:option_name => name, :option_value => value)
      end
    end
  end

  def value=(object)
    if WP::Utility.should_serialize?(object)
      option_value= WP::Utility.serialize(option_value)
    else
      option_value
    end
  end

  def value
    serialized? ? unserialize : option_value
  end

  def serialized?
    WP::Utility.is_serialized? option_value
  end

  private
  def unserialize
    WP::Utility.unserialize option_value
  end
end