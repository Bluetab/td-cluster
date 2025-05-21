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
end
