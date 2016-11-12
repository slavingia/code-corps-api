defmodule CodeCorps.StripeAccountControllerTest do
  use CodeCorps.ApiCase, resource_name: :stripe_account

  describe "index" do
    @tag authenticated: :admin
    test "lists all entries on index", %{conn: conn} do
      [stripe_account_1, stripe_account_2] = insert_pair(:stripe_account)

      conn
      |> request_index
      |> json_response(200)
      |> assert_ids_from_response([stripe_account_1.id, stripe_account_2.id])
    end

    test "renders 401 when not authenticated", %{conn: conn} do
      assert conn |> request_index |> json_response(401)

    end

    @tag :authenticated
    test "renders 403 when not authorized", %{conn: conn} do
      assert conn |> request_index |> json_response(403)

    end
  end


  describe "show" do
    test "shows chosen resource", %{conn: conn} do
      stripe_account = insert(:stripe_account)

      conn
      |> request_show(stripe_account)
      |> json_response(200)
      |> Map.get("data")
      |> assert_result_id(stripe_account.id)
    end
    
  end




end
