module Test
  module SharedContext
    include ActiveMerchantClone::Billing

    def credit_card(number = "4242424242424242", options = {})
      defaults = {
        first_name: "foo",
        last_name: "bar",
        number: number,
        month: expiration_date.month,
        year: expiration_date.year,
        verification_value: "123",
        brand: "visa"
      }.update(options)

      CreditCard.new(defaults)
    end

    private

    def expiration_date
      @_expiration_date ||= Date.new((Time.now.year + 1), 2, 2)
    end
  end
end
