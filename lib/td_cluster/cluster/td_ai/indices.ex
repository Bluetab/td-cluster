defmodule TdCluster.Cluster.TdAi.Indices do
  @moduledoc """
  Module to interact with tdai indices
  """

  alias TdCluster.Cluster

  def list(args \\ %{}) do
    Cluster.TdAi.call_ai(TdAi.Indices, :list_indices, [args])
  end
end
