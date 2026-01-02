defmodule TdCluster.TdDd.Search do
  @moduledoc """
  Module to interact with the search of the dd cluster
  """

  alias TdCluster.ClusterHandler
  alias TdDd.DataStructures.Search

  def build_filters(permissions, opts \\ []) do
    call_dd(Search.Query, :build_filters, [permissions, opts])
  end

  defp call_dd(module, function, args), do: ClusterHandler.call(:dd, module, function, args)
end
