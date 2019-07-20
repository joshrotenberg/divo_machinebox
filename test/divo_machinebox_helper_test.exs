defmodule DivoMachinebox.HelperTest do
  use ExUnit.Case
  doctest DivoMachinebox.Helper

  describe "test envars_to_environment" do
    test "return a list of environment variables for the given keyword list" do
      envs = DivoMachinebox.Helper.envars_to_environment(a: "b", c: 3)
      assert envs == ["MB_A=b", "MB_C=3"]
    end

    test "return a list of environment variables the supplied prefix" do
      envs = DivoMachinebox.Helper.envars_to_environment([a: "b", c: 3], "PREFIX_")
      assert envs == ["PREFIX_A=b", "PREFIX_C=3"]
    end
  end

  describe "test convert_to_environment" do
    test "returns a " do
      #      DivoMachinebox.Helper.convert_to_environment([a: 1], [:a], "doof")
      #      |> IO.inspect()
    end
  end
end
