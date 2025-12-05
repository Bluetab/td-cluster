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

  def generate_vector(expect, params, index_type, collection_name, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :bg,
                                                 TdBg.BusinessConcepts,
                                                 :generate_vector,
                                                 [^params, ^index_type, ^collection_name] ->
      expected
    end)
  end

  def get_unique_concept(expect, name, domain_id, concept_type, expected, times \\ 1) do
    expect.(
      MockClusterHandler,
      :call,
      times,
      fn :bg, TdBg.BusinessConcepts, :get_unique_concept, [arg_name, arg_domain_id, arg_concept_type]
         when arg_name == name and
         arg_domain_id == domain_id and
         arg_concept_type == concept_type ->
        expected
      end
    )
  end

  def get_unique_concept_stub(stub_fn, name, domain_id, concept_type_fn) do
    stub_fn.(
      MockClusterHandler,
      :call,
      fn service, module, function, args ->
        case {service, module, function, args} do
          {:bg, TdBg.BusinessConcepts, :get_unique_concept, [arg_name, arg_domain_id, arg_concept_type]}
          when arg_name == name and arg_domain_id == domain_id ->
            concept_type_fn.(arg_concept_type)

          _ ->
            raise "Unexpected call: #{inspect({service, module, function, args})}"
        end
      end
    )
  end

  def create_bulk_upload_event(expect, event, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :bg,
                                                 TdBg.BusinessConcepts.BulkUploadEvents,
                                                 :create_bulk_upload_event,
                                                 [arg_event]
                                                 when event.status == arg_event.status ->
      expected
    end)
  end
end
