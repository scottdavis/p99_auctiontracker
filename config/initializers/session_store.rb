# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_auction_session',
  :secret      => '31127036e4424e73b665e1fb3229a30bf79cb38cc6a64773c1936c137acab6012b937b70dc53487522fcd01af0d1c052be12bc43b44c808c1b9aff06e28ad0f5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
