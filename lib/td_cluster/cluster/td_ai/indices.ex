defmodule TdCluster.Cluster.TdAi.Indices do
  @moduledoc """
  Module to interact with td ai indices
  """

  alias TdCluster.Cluster

  def list(args \\ []) do
    Cluster.TdAi.call_ai(TdAi.Indices, :list_indices, [args])
  end

  def exists_enabled?(args \\ [])  do
    Cluster.TdAi.call_ai(TdAi.Indices, :exists_enabled?, [args])
  end

  def first_enabled(args \\ [])  do
    Cluster.TdAi.call_ai(TdAi.Indices, :first_enabled, [args])
  end
end
