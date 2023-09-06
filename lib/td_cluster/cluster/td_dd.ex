defmodule TdCluster.Cluster.TdDd do
  alias TdCluster.ClusterHandler

  def get_reference_dataset(id) do
    call_dd(TdDd.ReferenceData, :get, [id])
  end

  defp call_dd(module, function, args), do: ClusterHandler.call(:dd, module, function, args)
end
