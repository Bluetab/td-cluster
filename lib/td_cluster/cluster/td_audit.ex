defmodule TdCluster.Cluster.TdAudit do
  @moduledoc """
  Cluster handler for TdAudit
  """

  alias TdCluster.ClusterHandler

  def call_audit!(module, function, args), do: ClusterHandler.call!(:audit, module, function, args)
end
