defmodule TdCluster.Cluster.TdAi.Indices do
  @moduledoc """
  Module to interact with tdai indices
  """

  alias TdCluster.Cluster

  def list(args \\ %{}) do
    Cluster.TdAi.call_ai(TdAi.Indices, :list_indices, [args])
  end

  def exists_enabled? do
    Cluster.TdAi.call_ai(TdAi.Indices, :exists_enabled?, [])
  end
end
