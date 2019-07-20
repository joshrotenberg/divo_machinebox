defmodule DivoMachinebox do
  @moduledoc """
  Defines a generic Machinebox stack as a map compatible
  with divo for building a docker-compose file. See the box specific modules.
  """

  @common_vars [
    :key,
    :port,
    :address,
    :disable_cors,
    :basicauth_user,
    :basicauth_pass,
    :download_timeout_seconds
  ]

  defmacro __using__(opts \\ []) do
    box_name = Keyword.get(opts, :box_name)
    box_vars = Keyword.get(opts, :box_vars)

    quote do
      @behaviour Divo.Stack

      @impl Divo.Stack
      @spec gen_stack([tuple()]) :: map()
      def gen_stack(opts \\ []) do
        box_version = Keyword.get(opts, :box_verion, "latest")
        port = Keyword.get(opts, :port, 8080)
        address = Keyword.get(opts, :address, "0.0.0.0")

        include_healthcheck = Keyword.get(opts, :include_healthcheck, true)

        bn = unquote(box_name)
        bv = unquote(box_vars)
        cv = unquote(@common_vars)

        %{
          bn => %{
            image: "machinebox/#{bn}:#{box_version}",
            ports: ["#{port}:#{port}"],
            environment:
              DivoMachinebox.Helper.convert_to_environment(opts, cv, "MB_") ++
                DivoMachinebox.Helper.convert_to_environment(
                  opts,
                  bv,
                  Enum.join(["MB_", bn, "_"])
                ),
            healthcheck: %{
              test: "curl -sS http://#{address}:#{port}/healthz || exit 1",
              interval: "5s",
              timeout: "10s",
              retries: 3
            }
          }
        }
      end
    end
  end
end

defmodule DivoMachinebox.Classificationbox do
  @moduledoc """
  Defines a Classificationbox stack as a map compatible
  with divo for building a docker-compose file.
  """
  @classificationbox_vars [:state_url, :state_poll_seconds]
  use DivoMachinebox, box_name: "classificationbox", box_vars: @classificationbox_vars
end

defmodule DivoMachinebox.Facebox do
  @facebox_vars [
    :state_url,
    :state_poll_seconds,
    :read_only,
    :index_refresh_seconds,
    :disable_recognition,
    :redis,
    :redis_db,
    :redis_password,
    :redis_sentinel,
    :redis_sentinel_master
  ]
  use DivoMachinebox, box_name: "facebox", box_vars: @facebox_vars
end
