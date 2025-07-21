defmodule TdCluster.Cluster.TdIe do
  @moduledoc """
  Cluster handler for TdLm
  """

  alias TdCluster.ClusterHandler

  def get_ingest_by_name(ingest_id) do
    call_lm(TdIe.Ingests, :get_ingest_by_name, [ingest_id])
  end

  defp call_lm(module, function, args), do: ClusterHandler.call(:lm, module, function, args)
end
