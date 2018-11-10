defmodule BusiApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :busi_api,
    module: BusiApiWeb.Auth.Guardian,
    error_handler: BusiApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
