defmodule TdCluster.Cluster.TdBg do
  @moduledoc """
  Cluster handler for TdBg
  """

  alias TdCluster.ClusterHandler

  def list_business_concept_versions(criteria) do
    call_bg(TdBg.BusinessConcepts, :list_business_concept_versions, [criteria])
  end

  defp call_bg(module, function, args), do: ClusterHandler.call(:bg, module, function, args)
end
