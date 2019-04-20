Rails.configuration.stripe = {
  :publishable_key => "pk_test_d83PG8AMiVN069NuVKM0k3wN00QlkJhrjk",
  :secret_key      => "sk_test_1t5WrLmvRo6bSJ90TxXpnXY400mgwPUxPm"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key] 