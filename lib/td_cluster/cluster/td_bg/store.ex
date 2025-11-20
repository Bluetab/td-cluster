defmodule TdCluster.TdBg.Store do
  @moduledoc """
  Module to interact with the store of the bg cluster
  """

  alias TdCluster.ClusterHandler

  def fetch(ids) do
    {:ok, %{schema: schema, store: store}} = call_bg(TdBg.BusinessConcept.Search, :store, [])
    call_bg(store, :fetch, [schema, ids])
  end

  defp call_bg(module, function, args), do: ClusterHandler.call(:bg, module, function, args)
end
