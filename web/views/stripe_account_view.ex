defmodule CodeCorps.StripeAccountView do
  use CodeCorps.PreloadHelpers, default_preloads: [:organization]
  use CodeCorps.Web, :view
  use JaSerializer.PhoenixView

  has_one :organization, serializer: CodeCorps.OrganizationView

end
