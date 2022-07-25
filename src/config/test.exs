import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
# config :facturacion, Facturacion.Repo,
#   username: "postgres",
#   password: "postgres",
#   hostname: "localhost",
#   database: "facturacion_test#{System.get_env("MIX_TEST_PARTITION")}",
#   pool: Ecto.Adapters.SQL.Sandbox,
#   pool_size: 10

config :facturacion, Facturacion.Repo,
  # database: "/Users/ismqui/dev/elixir/facturacion_test.db"
  database: Path.expand("../facturacion_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :facturacion, FacturacionWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "eMBHWsBXWRLfbrgY5CkcpxnnjwTCObkDWtAdM20bLkbb+AZS89nQTiu0T0b7x3S/",
  server: false

# In test we don't send emails.
config :facturacion, Facturacion.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
