defmodule CodeCorps.StripeCardTest do
  use CodeCorps.PolicyCase

  import CodeCorps.StripeCardPolicy, only: [create?: 2, delete?: 2, show?: 2]
  import CodeCorps.StripeCard, only: [create_changeset: 2]

  alias CodeCorps.StripeCard

  describe "create?" do
    test "returns true if user is creating their own record" do
      user = insert(:user)
      changeset = %StripeCard{} |> create_changeset(%{user_id: user.id})

      assert create?(user, changeset)
    end

    test "returns false if user is creating someone else's record" do
      user = build(:user)
      changeset = %StripeCard{} |> create_changeset(%{user_id: "someone-else"})

      refute create?(user, changeset)
    end
  end

  describe "delete?" do
    test "returns true if user is deleting their own record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card, user: user)

      assert delete?(user, stripe_card)
    end

    test "returns false if user is deleting someone else's record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card)

      refute delete?(user, stripe_card)
    end
  end

  describe "show?" do
    test "returns true if user is viewing their own record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card, user: user)

      assert show?(user, stripe_card)
    end

    test "returns false if user is viewing someone else's record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card)

      refute show?(user, stripe_card)
    end
  end
end
