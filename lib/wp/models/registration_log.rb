class WP::RegistrationLog
  include DataMapper::Resource
  storage_names[:default] = "wp_registration_log"

  property :ID, Serial
  property :email, String
  property :IP, String
  property :blog_id, String
  property :date_registerd, DateTime

end