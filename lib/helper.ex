defmodule DivoMachinebox.Helper do
  @doc """
  Converts a Keyword list to a list of string-based environment variables
  prefixed with the given prefix.

  ## Examples

  iex> DivoMachinebox.Helper.envars_to_environment([foo: "bar"], "MB_")
  ["MB_FOO=bar"]
  """
  def envars_to_environment(vars, prefix \\ "MB_") do
    vars
    |> Enum.map(fn {k, v} ->
      new_key =
        k
        |> Atom.to_string()
        |> String.replace_prefix("", prefix)
        |> String.upcase()

      "#{new_key}=#{v}"
    end)
  end

  @spec convert_to_environment(keyword, [atom], any) :: [any]
  def convert_to_environment(opts, vars, prefix) do
    opts
    |> Keyword.take(vars)
    |> envars_to_environment(prefix)
  end

  def stuff do
  end
end
