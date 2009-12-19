require "php_serialize"

module WP::Utility
  extend self

  ##
  # Tries to determine if the value was serialized
  # modeled after 'is_serialized' at /wp-include/functions.php:247
  def is_serialized?(data)
    return false unless data.is_a? String
    data.strip!
    return true if data == 'N'
    badions = data.match /^([adObis]):/
    return false unless badions
    case
      when %w(a O s).include?(badions[1]) && data.match(/^#{badions[1]}:[0-9]+:.*[;}]/s) then true
      when %w(b i d).include?(badions[1]) && data.match(/^#{badions[1]}:[0-9.E-]+;/) then true
    else
      false
    end
  end

  ##
  # delegates to php_serialize gem
  def serialize(object)
    PHP.serialize(object)
  end

  ##
  # delegates to php_serialize gem
  def unserialize(data)
    PHP.unserialize(data)
  end
end