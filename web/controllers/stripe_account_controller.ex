defmodule CodeCorps.StripeAccountController do
  use CodeCorps.Web, :controller
  use JaResource

  alias CodeCorps.StripeAccount

  # plug :load_and_authorize_resource, model: StripeAccount, only: [:show]
  plug JaResource


end
