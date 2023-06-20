defmodule TdCluster.ProcessGroup do
  @moduledoc """
  Supervisor for :pg module. Start and supervise process group
  """

  use Supervisor

  @default_scope :truedat

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    children = [
      %{
        id: :pg,
        start: {:pg, :start_link, [get_scope()]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_scope, do: Application.get_env(:td_cluster, :scope, @default_scope)
end
