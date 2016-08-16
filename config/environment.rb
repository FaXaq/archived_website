# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "contact@norra.fr",
  :password => "Azerty123!!/",
  :domain => "norra.fr",
  :address => 'SSL0.OVH.NET',
  :port => 465,
  :authentication => :plain,
  :ssl => true,
  :enable_starttls_auto => true
}
