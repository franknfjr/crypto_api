import Config

config :crypto_api, CryptoApi.Repo,
  socket_dir: "/tmp/cloudsql/cryptoapi-347423:us-central1:cryptodb/",
  database: "crypto_api",
  username: "postgres",
  password: "postgres",
  pool_size: 1
