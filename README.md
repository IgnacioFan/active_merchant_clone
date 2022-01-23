# ActiveMerchantClone

A self-learning project origin from a well-known open source librar - Active Merchant.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_merchant_clone'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_merchant_clone

## Test

```
rake # default(test_billing)
raket test_billing
```

## todos

- [x] establish basic credit card model
- [x] enhance credit card formatting
- [x] add validate method for credit card model
- [x] enhance test scope and test helper
- [ ] refactor credit_card and credit_card_methods
- [ ] ...
- [ ] enhance gateway
- [ ] enhance gateways
- [ ] enhance payment_token

### task1 - establish basic credit card model
- add `Model`(class) and `Empty`(a value object)
- add `CreditCard` and test
- add `CreditCardMethods` and add test

### task2 - enhance credit card formatting
- add `CreditCardFormatting` and test

### task3 - add validate method for credit card model
- add `validate_essential_attributes` and test
- add `ExpiryDate` and test
- add `validate_verification_value` and test
- add `validate_card_brand` and test
- add `validate_card_number` and test

### task4 - enhance test helper
- add `test_helper`
- highlight console error log messages
- use rake to run all test suits
- organise all billing test
- shorten const declaration

### task5 - refactor credit_card and credit_card_methods
- refactor `credit_card` and test scope
- add module - `present`
- refactor `credit_card_methods` and test scope
