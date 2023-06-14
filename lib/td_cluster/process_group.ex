defmodule TdCluster.ProcessGroup do
  use Supervisor

  @scope Application.compile_env(:td_cluster, :scope, :truedat)

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    children = [
      %{
        id: :pg,
        start: {:pg, :start_link, [@scope]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_scope(), do: @scope
 end
