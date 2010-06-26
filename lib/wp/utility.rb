module WP::Utility
  extend self

  ##
  # Tries to determine if the value was serialized
  # modeled after 'is_serialized' at /wp-include/functions.php:247
  def is_serialized?(data)
    return false unless data.is_a? String
    data.strip!
    case
      when data == 'N' then true
      when (matches = data.match(/^([aOs]):/)) && data.match(/^#{matches[1]}:[0-9]+:.*[;}]/s) then true
      when (matches = data.match(/^([bid]):/)) && data.match(/^#{matches[1]}:[0-9.E-]+;/) then true
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

  def should_serialize?(object)
    false
  end
end