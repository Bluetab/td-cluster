defmodule TdCluster.TdQx.Store do
  @moduledoc """
  Module to interact with the store of the qx cluster
  """

  alias TdCluster.ClusterHandler

  def fetch(params, index \\ :quality_control_versions) do
    {:ok, %{schema: schema, store: store}} = call_qx(TdQx.Search, :store, [index])
    call_qx(store, :fetch, [schema, params])
  end

  defp call_qx(module, function, args), do: ClusterHandler.call(:qx, module, function, args)
end
