defmodule TdCluster.TdDd.Store do
  @moduledoc """
  Module to interact with the store of the bg cluster
  """

  alias TdCluster.Cluster

  def fetch(ids) do
    {:ok, %{schema: schema, store: store}} =
      Cluster.TdDd.call_dd(TdDd.DataStructures.Search, :store, [])

    Cluster.TdDd.call_dd(store, :fetch, [schema, ids])
  end
end
