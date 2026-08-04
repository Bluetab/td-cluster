defmodule TdCluster.Cluster.TdAi do
  @moduledoc """
  Cluster handler for TdAi
  """

  alias TdCluster.ClusterHandler

  def call_ai(module, function, args), do: ClusterHandler.call(:ai, module, function, args)
end
