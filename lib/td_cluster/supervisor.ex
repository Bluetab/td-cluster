defmodule TdCluster.Supervisor do

  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    topologies = Application.get_env(:td_cluster, :topologies)

    children = [
      TdCluster.ProcessGroup,
      {Cluster.Supervisor, [topologies, [name: TdCluster.ClusterSupervisor]]},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

end
