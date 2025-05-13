defmodule TdCluster.TestHelpers.TdAiMock.Indices do
  @moduledoc """
  Mocks Clusters for tests
  """

  def list(expect, args, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai,
                                                 TdAi.Indices,
                                                 :available_resource_mapping,
                                                 [^args] ->
      expected
    end)
  end

  def exists_enabled?(expect, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Indices, :exists_enabled?, [] ->
      expected
    end)
  end
end
