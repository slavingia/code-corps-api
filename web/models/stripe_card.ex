defmodule CodeCorps.StripePlatformCard do
  use CodeCorps.Web, :model

  schema "stripe_platform_cards" do
    field :brand, :string
    field :customer_id_from_stripe, :string
    field :cvc_check, :string
    field :exp_month, :integer
    field :exp_year, :integer
    field :id_from_stripe, :string, null: false
    field :last4, :string
    field :name, :string

    belongs_to :user, CodeCorps.User

    timestamps()
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:brand, :customer_id_from_stripe, :cvc_check, :exp_month, :exp_year, :last4, :name, :id_from_stripe, :user_id])
    |> validate_required([:brand, :exp_month, :exp_year, :cvc_check, :last4, :id_from_stripe, :user_id])
    |> assoc_constraint(:user)
  end
end
