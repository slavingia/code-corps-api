defmodule CodeCorps.StripeCardController do
  use CodeCorps.Web, :controller
  use JaResource

  import CodeCorps.Helpers.Query, only: [id_filter: 2]

  alias CodeCorps.StripeCard

  plug :load_and_authorize_resource, model: StripeCard, only: [:show, :delete], preload: [:user]
  plug :load_and_authorize_changeset, model: StripeCard, only: [:create]

  plug JaResource

  def filter(_conn, query, "id", id_list) do
    query |> id_filter(id_list)
  end

  def handle_create(conn, attributes) do
    %StripeCard{}
    |> StripeCard.create_changeset(attributes)
    |> Repo.insert
    |> CodeCorps.Analytics.Segment.track(:created, conn)
  end

  def handle_delete(conn, record) do
    record
    |> Repo.delete
    |> CodeCorps.Analytics.Segment.track(:deleted, conn)
  end
end
