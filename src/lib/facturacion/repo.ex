defmodule Facturacion.Repo do
  use Ecto.Repo,
    otp_app: :facturacion,
    adapter: Ecto.Adapters.SQLite3
end
