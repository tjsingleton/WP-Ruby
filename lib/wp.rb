require 'rubygems'
require 'dm-core'
require 'pathname'

DataMapper.setup(:default, 'mysql://localhost/wordpress')

module WP

end

PWD = Pathname.getwd
Pathname.glob(PWD.join("wp", "*.rb")).each do |file|
  require file
end