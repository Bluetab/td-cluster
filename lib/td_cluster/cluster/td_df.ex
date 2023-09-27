defmodule TdCluster.Cluster.TdDf do
  @moduledoc """
  Cluster handler for TdDf
  """

  alias TdCluster.ClusterHandler

  def get_template_by_name!(name) do
    call_dd(TdDf.Templates, :get_template_by_name!, [name])
  end

  defp call_dd(module, function, args), do: ClusterHandler.call(:df, module, function, args)
end
