defmodule TdCluster.Cluster.TdBg do
  @moduledoc """
  Cluster handler for TdBg
  """

  alias TdCluster.ClusterHandler

  def list_business_concept_versions(criteria) do
    call_bg(TdBg.BusinessConcepts, :list_business_concept_versions, [criteria])
  end

  def get_business_concept_version(id, version) do
    call_bg(TdBg.BusinessConcepts, :get_business_concept_version, [id, version])
  end

  def generate_vector(params, collection_name \\ nil) do
    call_bg(TdBg.BusinessConcepts, :generate_vector, [params, collection_name])
  end

  def get_concept_by_name_in_domain(name, domain_id) do
    call_bg(TdBg.BusinessConcepts, :get_concept_by_name_in_domain, [name, domain_id])
  end

  def create_bulk_upload_event(event) do
    call_bg(TdBg.BusinessConcepts.BulkUploadEvents, :create_bulk_upload_event, [event])
  end

  defp call_bg(module, function, args), do: ClusterHandler.call(:bg, module, function, args)
end
