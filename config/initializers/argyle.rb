require_relative '../../plaidkeys.rb'

Argyle.configure do |config|
  config.key = @public_key         # Public key from Plaid
  config.secret = @secret   # Secret from Plaid
  config.customer_id = @client_id  # Client ID from Plaid
  config.product = "connect" 
end
