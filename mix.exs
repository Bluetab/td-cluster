defmodule TdCluster.MixProject do
  use Mix.Project

  def project do
    [
      app: :td_cluster,
      version: "7.14.1",
      elixir: "~> 1.18",
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
      {:credo, "~> 1.7.11", only: [:dev, :test], runtime: false},
      {:libcluster, "~> 3.4.1"}
    ]
  end
end
