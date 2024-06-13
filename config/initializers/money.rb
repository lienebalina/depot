require 'money'
require 'eu_central_bank'

# Use currency-specific formatting rules based on locale
Money.locale_backend = :currency
I18n.enforce_available_locales = false

# Create new instance of bank
bank = EuCentralBank.new
# Fetch the latest exchange rates from ECB
bank.update_rates

# Set ECB as default bank
Money.default_bank = bank

# Set default currency as USD
Money.default_currency = Money::Currency.new("USD")
