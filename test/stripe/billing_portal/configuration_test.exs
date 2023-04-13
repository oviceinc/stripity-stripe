defmodule Stripe.BillingPortal.ConfigurationTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      customer: "cus_123",
      return_url: "https://stripe.com"
    }

    assert {:ok, %Stripe.BillingPortal.Configuration{}} =
             Stripe.BillingPortal.Configuration.create(params)

    assert_stripe_requested(:post, "/v1/billing_portal/configurations")
  end
end
