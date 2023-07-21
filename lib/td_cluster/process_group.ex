defmodule TdCluster.ProcessGroup do
  @moduledoc """
  Supervisor for :pg module. Start and supervise process group
  """

  use Supervisor

  @default_scope :truedat

  def start_link(args) do
    link = Supervisor.start_link(__MODULE__, args, name: __MODULE__)

    :td_cluster
    |> Application.get_env(:groups)
    |> Enum.each(fn group ->
      :pg.join(@default_scope, group, self())
    end)

    link
  end

  @impl true
  def init(_args) do
    children = [
      %{
        id: :pg,
        start: {:pg, :start_link, [@default_scope]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_scope, do: @default_scope
end
