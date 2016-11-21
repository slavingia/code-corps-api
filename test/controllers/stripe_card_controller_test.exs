defmodule CodeCorps.StripePlatformCardControllerTest do
  use CodeCorps.ApiCase, resource_name: :stripe_platform_card

  describe "show" do
    @tag :authenticated
    test "shows resource when authenticated and authorized", %{conn: conn, current_user: current_user} do
      stripe_platform_card = insert(:stripe_platform_card, user: current_user)
      conn
      |> request_show(stripe_platform_card)
      |> json_response(200)
      |> Map.get("data")
      |> assert_result_id(stripe_platform_card.id)
    end

    test "renders 401 when unauthenticated", %{conn: conn} do
      stripe_platform_card = insert(:stripe_platform_card)

      assert conn |> request_show(stripe_platform_card) |> json_response(401)
    end

    @tag :authenticated
    test "renders 403 when not authorized", %{conn: conn} do
      stripe_platform_card = insert(:stripe_platform_card)
      assert conn |> request_show(stripe_platform_card) |> json_response(403)
    end

    @tag :authenticated
    test "renders 404 when record not found", %{conn: conn} do
      assert conn |> request_show(:not_found) |> json_response(404)
    end
  end

  describe "create" do
    @tag :authenticated
    test "creates and renders resource when data is valid", %{conn: conn, current_user: current_user} do
      valid_attrs = %{stripe_token: "tok_test123456", user: current_user}
      assert conn |> request_create(valid_attrs) |> json_response(201)
    end

    @tag :authenticated
    test "renders 422 when data is invalid", %{conn: conn, current_user: current_user} do
      invalid_attrs = %{stripe_token: nil, user: current_user}
      assert conn |> request_create(invalid_attrs) |> json_response(422)
    end

    test "renders 401 when unauthenticated", %{conn: conn} do
      assert conn |> request_create |> json_response(401)
    end

    @tag :authenticated
    test "renders 403 when not authorized", %{conn: conn} do
      assert conn |> request_create |>  json_response(403)
    end
  end

  describe "delete" do
    @tag :authenticated
    test "deletes resource", %{conn: conn, current_user: current_user} do
      stripe_platform_card = insert(:stripe_platform_card, user: current_user)
      assert conn |> request_delete(stripe_platform_card) |> response(204)
    end

    test "renders 401 when unauthenticated", %{conn: conn} do
      assert conn |> request_delete |> json_response(401)
    end

    @tag :authenticated
    test "403 when not authorized", %{conn: conn} do
      assert conn |> request_delete |> json_response(403)
    end

    @tag :authenticated
    test "renders 404 when record not found", %{conn: conn} do
      assert conn |> request_delete(:not_found) |> json_response(404)
    end
  end
end
