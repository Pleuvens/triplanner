import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :triplanner, Triplanner.Repo,
  username: "dev",
  password: "dev",
  hostname: "localhost",
  database: "triplanner_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :triplanner, TriplannerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "f9wC66mBnkqb/d5w8tXpMtVeRu6dGXaTLeDlxEsxpCtYosmaaLnLAS75tSrUI3Wj",
  server: false

# In test we don't send emails.
config :triplanner, Triplanner.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
