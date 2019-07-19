defmodule DivoMachineboxTest do
  use ExUnit.Case
  doctest DivoMachinebox

  describe "test the various box configurations" do
    test "classification box" do
      expected = %{
        "classificationbox" => %{
          environment: ["MB_KEY=123", "MB_CLASSIFICATIONBOX_STATE_URL=http://my.url"],
          healthcheck: %{
            interval: "5s",
            retries: 3,
            test: "curl -sS http://0.0.0.0:8080/healthz || exit 1",
            timeout: "10s"
          },
          image: "machinebox/classificationbox:latest",
          ports: ["8080:8080"]
        }
      }

      actual = DivoMachinebox.Classificationbox.gen_stack(key: "123", state_url: "http://my.url")

      assert expected == actual
    end

    test "facebox" do
      expected = %{
        "facebox" => %{
          environment: [
            "MB_KEY=123",
            "MB_FACEBOX_STATE_URL=http://my.url",
            "MB_FACEBOX_REDIS=yeah"
          ],
          healthcheck: %{
            interval: "5s",
            retries: 3,
            test: "curl -sS http://0.0.0.0:8080/healthz || exit 1",
            timeout: "10s"
          },
          image: "machinebox/facebox:latest",
          ports: ["8080:8080"]
        }
      }

      actual =
        DivoMachinebox.Facebox.gen_stack(key: "123", state_url: "http://my.url", redis: "yeah")

      assert expected == actual
    end
  end
end
