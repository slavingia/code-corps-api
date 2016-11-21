defmodule CodeCorps.StripePlatformCardTest do
  use CodeCorps.ModelCase

  alias CodeCorps.StripePlatformCard

  @valid_attrs %{
    id_from_stripe: "abc123"
  }

  @invalid_attrs %{}

  describe "create_changeset/2" do
    test "reports as valid when attributes are valid" do
      user_id = insert(:user).id

      changes = Map.merge(@valid_attrs, %{user_id: user_id})
      changeset = StripePlatformCard.create_changeset(%StripePlatformCard{}, changes)
      assert changeset.valid?
    end

    test "reports as invalid when attributes are invalid" do
      changeset = StripePlatformCard.create_changeset(%StripePlatformCard{}, @invalid_attrs)
      refute changeset.valid?

      assert changeset.errors[:id_from_stripe] == {"can't be blank", []}
      assert changeset.errors[:user_id] == {"can't be blank", []}
    end

    test "ensures associations link to records that exist" do
      attrs =  @valid_attrs |> Map.merge(%{user_id: -1})

      { result, changeset } =
        StripePlatformCard.create_changeset(%StripePlatformCard{}, attrs)
        |> Repo.insert

      assert result == :error
      refute changeset.valid?
      assert changeset.errors[:user] == {"does not exist", []}
    end
  end
end
