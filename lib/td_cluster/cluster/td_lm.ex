defmodule TdCluster.Cluster.TdLm do
  @moduledoc """
  Cluster handler for TdLm
  """

  alias TdCluster.ClusterHandler

  def clone_relations(original_source_id, new_source_id, relation_type, claims) do
    call_lm(TdLm.Resources, :clone_relations, [
      original_source_id,
      new_source_id,
      relation_type,
      claims
    ])
  end

  def refresh_search_data(index, ids) do
    call_lm(TdLm.Resources, :refresh_search_data, [index, ids])
  end

  defp call_lm(module, function, args), do: ClusterHandler.call(:lm, module, function, args)
end
