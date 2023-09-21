defmodule TdCluster.MixProject do
  use Mix.Project

  def project do
    [
      app: :td_cluster,
      version: "5.15.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {TdCluster.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:libcluster, "~> 3.3"}
    ]
  end
end
