defmodule TdCluster.TestHelpers.TdAiMock.Embeddings do
  @moduledoc """
  Mocks Clusters for tests
  """

  def list(expect, args, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Embeddings, :all, [^args] ->
      expected
    end)
  end
end
