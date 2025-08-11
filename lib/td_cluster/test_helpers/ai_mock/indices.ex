defmodule TdCluster.TestHelpers.TdAiMock.Indices do
  @moduledoc """
  Mocks Clusters for tests
  """

  def list_indices(expect, args, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Indices, :list_indices, [^args] ->
      expected
    end)
  end

  def exists_enabled?(expect, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Indices, :exists_enabled?, [] ->
      expected
    end)
  end

  def first_enabled(expect, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :ai, TdAi.Indices, :first_enabled, [] ->
      expected
    end)
  end
end
