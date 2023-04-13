defmodule Stripe.BillingPortal.Configuration do
  @moduledoc """
  Work with Stripe Billing (aka Self-serve) Portal Session objects.

  You can:

  - Create a session

  Stripe API reference: https://stripe.com/docs/api/customer_portal
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          :id => Stripe.id(),
          :object => String.t(),
          :active => boolean(),
          :created => Stripe.timestamp(),
          :customer => Stripe.id(),
          :livemode => boolean()
        }

  @type allowed_updates :: :name | :email | :address | :shipping | :phone | :tax_id
  @type customer_update :: %{:allowed_updates => [allowed_updates], :enabled => boolean}
  @type features :: %{
          :customer_update => customer_update,
          :invoice_history => %{:enabled => boolean}
        }
  @type business_profile :: %{
          :privacy_policy_url => String.t(),
          :terms_of_service_url => String.t()
        }
  @type portal_configuration_params :: %{
          :features => features,
          :business_profile => business_profile
        }
  defstruct [
    :id,
    :object,
    :active,
    :created,
    :customer,
    :livemode
  ]

  @plural_endpoint "billing_portal/configurations"

  @spec create(portal_configuration_params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end
end
