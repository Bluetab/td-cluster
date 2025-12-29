defmodule TdCluster.TdBg.Search do
  @moduledoc """
  Module to interact with the search of the bg cluster
  """

  alias TdBg.BusinessConcepts.Search
  alias TdCluster.ClusterHandler

  def build_filters(permissions, opts \\ []) do
    call_bg(Search.Query, :build_filters, [permissions, opts])
  end

  defp call_bg(module, function, args), do: ClusterHandler.call(:bg, module, function, args)
end
