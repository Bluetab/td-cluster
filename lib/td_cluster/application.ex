defmodule TdCluster.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TdCluster.Supervisor]

    :td_cluster
    |> Application.get_env(:env)
    |> children()
    |> Supervisor.start_link(opts)
  end

  defp children(:test), do: []
  defp children(_), do
    current_topology = fetch_current_topology()
    topologies =  fetch_topologies()
    |> Keyword.filter(fn {key, _} -> key == String.to_atom(current_topology) end)

    [
      TdCluster.ProcessGroup,
      {Cluster.Supervisor, [topologies, [name: TdCluster.ClusterSupervisor]]}
    ]
  end

  defp fetch_current_topology, do: System.get_env("CLUSTER_TOPOLOGY", "local_epdm")
  defp fetch_topologies, do: [
    local_epdm: [ strategy: Elixir.Cluster.Strategy.LocalEpmd ],
    k8s: [
      strategy: Elixir.Cluster.Strategy.Kubernetes,
      config: [
        mode: :ip,
        kubernetes_node_basename: System.get_env("K8S_NODE_BASENAME", "truedat"),
        kubernetes_selector: System.get_env("K8S_SELECTOR", ""),
        kubernetes_namespace: System.get_env("K8S_NAMESPACE", "default"),
        polling_interval: 10_000
      ]
    ],
    docker: [ strategy: Elixir.Cluster.Strategy.Gossip ]
  ]
end
