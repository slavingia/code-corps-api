defmodule CodeCorps.StripeConnectCard do
  use CodeCorps.Web, :model

  schema "stripe_connect_cards" do
    field :id_from_stripe, :string, null: false

    belongs_to :stripe_account, CodeCorps.StripeAccount
    belongs_to :stripe_platform_card, CodeCorps.StripePlatformCard

    timestamps()
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:id_from_stripe, :stripe_account_id, :stripe_platform_card_id])
    |> validate_required([:id_from_stripe, :stripe_account_id, :stripe_platform_card_id])
    |> assoc_constraint(:stripe_account)
    |> assoc_constraint(:stripe_platform_card)
    |> unique_constraint(:id_from_stripe)
    |> unique_constraint(:stripe_account_id, name: :index_projects_on_user_id_role_id)
  end
end
