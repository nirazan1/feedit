# Stripe.api_key = " sk_test_QWfhyTideS44eq5zPisyBIqg"
# STRIPE_PUBLIC_KEY = "pk_test_90cx3d8wSmdCXKIR05p7q5E1"

#todo remove the key info from this file and have env variable
#todo recreate new API keys when do that
if Rails.env == 'production'
  Rails.configuration.stripe = {
      :publishable_key => "pk_live_I6CMRReXGsH58EHCqrEHguv0",
      :secret_key      => "sk_live_dp9SUmxGaHc6E1fVeA45evdm"
  }
else
  Rails.configuration.stripe = {
      :publishable_key => "pk_test_90cx3d8wSmdCXKIR05p7q5E1",
      :secret_key      => "sk_test_QWfhyTideS44eq5zPisyBIqg"
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]