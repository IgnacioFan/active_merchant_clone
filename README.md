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

## todos

- [x] establish basic credit card model
- [x] enhance credit card formatting
- [ ] add validate method for credit card model
- [ ] enhace test helper
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

### task4 - enhance test helper
