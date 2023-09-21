defmodule TdCluster.Cluster.TdDd do
  @moduledoc """
  Cluster handler for TdDd
  """

  alias TdCluster.ClusterHandler

  def get_reference_dataset(id) do
    call_dd(TdDd.ReferenceData, :get, [id])
  end

  def get_latest_structure_version(id) do
    call_dd(TdDd.DataStructures, :get_latest_version, [id, [:data_fields]])
  end

  defp call_dd(module, function, args), do: ClusterHandler.call(:dd, module, function, args)
end
