defmodule CodeCorps.Stripe.Adapters.StripePlatformCard do
  import CodeCorps.MapUtils, only: [rename: 3, keys_to_string: 1]

  @stripe_attributes [:brand, :customer_id_from_stripe, :cvc_check, :exp_month, :exp_year, :id, :last4, :name, :id_from_stripe, :user_id]

  def to_params(%{} = stripe_map) do
    stripe_map
    |> Map.from_struct
    |> Map.take(@stripe_attributes)
    |> rename(:id, :id_from_stripe)
    |> rename(:customer, :customer_id_from_stripe)
    |> keys_to_string
  end

  @non_stripe_attributes ["user_id"]

  def add_non_stripe_attributes(%{} = params, %{} = attributes) do
    attributes
    |> get_non_stripe_attributes
    |> add_to(params)
  end

  defp get_non_stripe_attributes(%{} = attributes) do
    attributes
    |> Map.take(@non_stripe_attributes)
  end

  defp add_to(%{} = attributes, %{} = params) do
    params
    |> Map.merge(attributes)
  end
end
