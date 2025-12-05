defmodule TdCluster.TestHelpers.TdAiMock.Embeddings do
  @moduledoc """
  Mocks Clusters for tests
  """

  def list(expect, text, index_type, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai,
                                                 TdAi.Embeddings,
                                                 :all,
                                                 [^text, ^index_type] ->
      expected
    end)
  end

  def generate_vector(expect, text, index_type, collection_name, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai,
                                                 TdAi.Embeddings,
                                                 :generate_vector,
                                                 [^text, ^index_type, ^collection_name] ->
      expected
    end)
  end
end
