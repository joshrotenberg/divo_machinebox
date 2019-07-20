defmodule DivoMachinebox.MixProject do
  use Mix.Project

  def project do
    [
      app: :divo_machinebox,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:divo, "~> 1.1"},
      {:credo, "~> 1.1", only: :dev, runtime: false},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp package do
    [
      licences: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/joshrotenberg/divo_machinebox"}
    ]
  end
end
