require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
# Load the rails application
require File.expand_path('../application', __FILE__)


# Initialize the rails application
Cf::Application.initialize!
