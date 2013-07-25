# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pideltapsi_session',
  :secret      => 'dd5a2602409b31b74c98fe604a9e50fcf2a76872ca494d88336b4d5115aa75c97c09dc43d10d029a5dd74eb50ef838c67b7eeda4285ddbfcf49b1aecb7571577'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
