defmodule TdCluster.TdQx.Store do
  @moduledoc """
  Module to interact with the store of the qx cluster
  """

  alias TdCluster.Cluster.TdQx, as: QxCluster

  def fetch(params, index \\ :quality_control_versions) do
    {:ok, %{schema: schema, store: store}} = QxCluster.call_qx(TdQx.Search, :store, [index])
    QxCluster.call_qx(store, :fetch, [schema, params])
  end
end
