# ActiveMerchantClone

ActiveMerchantClone is a side-project to provide plenty of payment gateways integration. Referring to a well-known open source project - ActiveMerchant, I built the project by diving into their source code, revamping them and then adding my own idea based on the current foundation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_merchant_clone'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_merchant_clone

## How to test
I use minitest to run tests.

```
# will run all tests
rake

# only run test files under test/billing folder
rake test_billing
```

## Example Usage

```ruby
# Send requests to the gateway's test servers
ActiveMerchant::Billing::Base.mode = :test

# Create a new credit card object
credit_card = ActiveMerchant::Billing::CreditCard.new(
  :number     => '4111111111111111',
  :month      => '8',
  :year       => '2009',
  :first_name => 'Tobias',
  :last_name  => 'Luetke',
  :verification_value  => '123'
)

if credit_card.valid?
  # Create a gateway object to the TrustCommerce service
  gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
    :login    => 'TestMerchant',
    :password => 'password'
  )

  # Authorize for $10 dollars (1000 cents)
  response = gateway.authorize(1000, credit_card)

  if response.success?
    # Capture the money
    gateway.capture(1000, response.authorization)
  else
    raise StandardError, response.message
  end
end
```

references http://activemerchant.org/

## todos

- [x] establish basic credit card model
- [x] enhance credit card formatting
- [x] add validate method for credit card model
- [x] enhance test scope and test helper
- [x] refactor credit_card and credit_card_methods
- [ ] establish basic gateway and test
- [ ] ...
- [ ] enhance gateway
- [ ] enhance gateways
- [ ] enhance payment_token

## Change logs

### phase 1 - establish basic credit card model
- add `Model`(class) and `Empty`(a value object)
- add `CreditCard` and test
- add `CreditCardMethods` and add test

### phase 2 - enhance credit card formatting
- add `CreditCardFormatting` and test

### phase 3 - add validate method for credit card model
- add `validate_essential_attributes` and test
- add `ExpiryDate` and test
- add `validate_verification_value` and test
- add `validate_card_brand` and test
- add `validate_card_number` and test

### phase 4 - enhance test helper
- add `test_helper`
- highlight console error log messages
- use rake to run all test suits
- organise all billing test
- shorten const declaration

### phase 5 - refactor credit_card and credit_card_methods
- refactor `credit_card` and test scope
- refactor `credit_card_methods` and test scope
- refactor `credit_card_formatting` and test scope
- refactor `credit_card_brands` and test scope
- refactor `expiry_date` and test scope

### phase 6 - establish basic gateway and test
- add gateway and borgus gateway(borgus is a testing gateway)
