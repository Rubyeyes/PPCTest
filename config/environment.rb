# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Config sendgrid
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app45643249@heroku.com'],
  :password       => ENV['uwb5a5lr1393'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
