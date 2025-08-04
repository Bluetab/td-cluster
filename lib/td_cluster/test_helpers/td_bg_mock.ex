defmodule TdCluster.TestHelpers.TdBgMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def get_business_concept_version(expect, id, version, expected, count \\ 1) do
    expect.(MockClusterHandler, :call, count, fn :bg,
                                                 TdBg.BusinessConcepts,
                                                 :get_business_concept_version,
                                                 [id_arg, version_arg]
                                                 when id_arg == id and version_arg == version ->
      expected
    end)
  end

  def generate_vector(expect, params, collection_name, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :bg,
                                                 TdBg.BusinessConcepts,
                                                 :generate_vector,
                                                 [^params, ^collection_name] ->
      expected
    end)
  end

  def get_concept_by_name_in_domain(expect, name, domain_id, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :bg,
                                                 TdBg.BusinessConcepts,
                                                 :get_concept_by_name_in_domain,
                                                 [arg_name, arg_domain_id]
                                                 when arg_name == name and
                                                        arg_domain_id == domain_id ->
      expected
    end)
  end

  def bulk_upload_event(expect, event, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :bg,
                                                 TdBg.BusinessConcepts.BulkUploadEvents,
                                                 :create_bulk_upload_event,
                                                 [event] ->
      expected
    end)
  end
end
