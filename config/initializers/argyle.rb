Argyle.configure do |config|
  config.key = ENV["PUBLIC_KEY"]        # Public key from Plaid
  config.secret = ENV["SECRET"]   # Secret from Plaid
  config.customer_id = ENV["CLIENT_ID"]  # Client ID from Plaid
  config.product = "connect"
end
