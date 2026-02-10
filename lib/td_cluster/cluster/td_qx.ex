defmodule TdCluster.Cluster.TdQx do
  @moduledoc """
  Cluster handler for TdQx
  """

  alias TdCluster.ClusterHandler

  def get_quality_control(id) do
    call_qx(TdQx.QualityControls, :get, [id])
  end

  def call_qx(module, function, args), do: ClusterHandler.call(:qx, module, function, args)
end
