defmodule CodeCorps.StripeAccountControllerTest do
  use CodeCorps.ApiCase, resource_name: :stripe_account

  @tag :authenticated
  describe "show" do
    test "shows chosen resource", %{conn: conn} do
      stripe_account = insert(:stripe_account)

      conn
      |> request_show(stripe_account)
      |> json_response(200)
      |> Map.get("data")
      |> assert_result_id(stripe_account.id)
    end

    test "renders 401 when unauthenticated", %{conn: conn} do
      stripe_account = insert(:stripe_account)
      assert conn |> request_show(stripe_account) |> json_response(401)
    end
  end
end
