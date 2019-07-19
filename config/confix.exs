import Config

config :divo_machinebox,
  key1: "value1",
  key2: "value2"

import_config "#{Mix.env()}.exs"
