defmodule Simon.MixProject do
  use Mix.Project

  def project do
    [
      app: :simon,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases() do
    [
      "site.build": ["build", "tailwind default --minify", "esbuild default"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_publisher, "~> 1.1.0"},
      {:phoenix_live_view, "~> 1.0.0-rc.0"},
      {:esbuild, "~> 0.8.1"},
      {:tailwind, "~> 0.2.2"}
    ]
  end
end
