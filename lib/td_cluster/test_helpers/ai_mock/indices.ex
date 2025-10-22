defmodule TdCluster.TestHelpers.TdAiMock.Indices do
  @moduledoc """
  Mocks Clusters for tests
  """

  def list_indices(expect, args, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Indices, :list_indices, [^args] ->
      expected
    end)
  end

  def exists_enabled?(expect, args, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Indices, :exists_enabled?, [^args] ->
      expected
    end)
  end

  def first_enabled(expect, args, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Indices, :first_enabled, [^args] ->
      expected
    end)
  end
end
