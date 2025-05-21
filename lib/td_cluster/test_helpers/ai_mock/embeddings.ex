defmodule TdCluster.TestHelpers.TdAiMock.Embeddings do
  @moduledoc """
  Mocks Clusters for tests
  """

  def list(expect, args, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Embeddings, :all, [^args] ->
      expected
    end)
  end

  def generate_vector(expect, text, collection_name, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai,
                                                 TdAi.Embeddings,
                                                 :generate_vector,
                                                 [^text, ^collection_name] ->
      expected
    end)
  end
end
