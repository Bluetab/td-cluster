defmodule TdCluster.Cluster.TdBg do
  @moduledoc """
  Cluster handler for TdBg
  """

  alias TdCluster.ClusterHandler

  def list_business_concept_versions(criteria) do
    call_bg(TdBg.BusinessConcepts, :list_business_concept_versions, [criteria])
  end

  # bulk relation business_concept
  def get_business_concept_version(id, version) do
    call_bg(TdBg.BusinessConcepts, :get_business_concept_version, [id, version])
  end

  def generate_vector(params, collection_name \\ nil) do
    call_bg(TdBg.BusinessConcepts, :generate_vector, [params, collection_name])
  end

  def start_bulk_load_event(params, user_id, file_hash, filename, task_ref) do
    event =
      %{
        user_id: user_id,
        status: "STARTED",
        file_hash: file_hash,
        task_reference: ref_to_string(task_ref),
        filename: filename
      }

    create_bulk_upload_event(params, event)
  end

  def completed_bulk_load_event(params, user_id, file_hash, filename, task_ref) do
    event =
      %{
        response: params,
        user_id: user_id,
        file_hash: file_hash,
        filename: filename,
        status: "COMPLETED",
        task_reference: ref_to_string(task_ref)
      }

    create_bulk_upload_event(params, event)
  end

  defp create_bulk_upload_event(params, event) do
    call_bg(TdBg.BusinessConcepts.BulkUploadEvent, :create_bulk_upload_event, [params, event])
  end

  def ref_to_string(ref) when is_reference(ref) do
    string_ref =
      ref
      |> :erlang.ref_to_list()
      |> List.to_string()

    Regex.run(~r/<(.*)>/, string_ref)
    |> Enum.at(1)
  end

  defp call_bg(module, function, args), do: ClusterHandler.call(:bg, module, function, args)
end
