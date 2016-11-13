defmodule CodeCorps.StripeCardTest do
  use CodeCorps.PolicyCase

  import CodeCorps.StripeCardPolicy, only: [create?: 2, delete?: 2, show?: 2]

  describe "create?" do
    test "returns true if user is creating their own record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card, user: user)

      assert create?(user, stripe_card)
    end

    test "returns false if user is creating someone else's record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card)

      refute create?(user, stripe_card)
    end
  end

  describe "delete?" do
    test "returns true if user is creating their own record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card, user: user)

      assert delete?(user, stripe_card)
    end

    test "returns false if user is creating someone else's record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card)

      refute delete?(user, stripe_card)
    end
  end

  describe "show?" do
    test "returns true if user is creating their own record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card, user: user)

      assert show?(user, stripe_card)
    end

    test "returns false if user is creating someone else's record" do
      user = insert(:user)
      stripe_card = insert(:stripe_card)

      refute show?(user, stripe_card)
    end
  end
end
