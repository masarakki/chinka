# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Chinka::Application.config.secret_key_base = ENV['SECRET'] || 'decc0ddea4498fe58a11dd49262141462a0c4572d1a64c3692a5ed408d81d93b69d9173a8cf4d4dcb7cf76b3c07e3161cdf11dfef595399d923c888de345b8ff'
