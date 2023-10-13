defmodule TdCluster.TestHelpers.TdLmMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def clone_relations(expect, params, expected) do
    expect.(MockClusterHandler, :call, 1, fn :lm, TdLm.Resources, :clone_relations, [arg]
                                             when arg == params ->
      expected
    end)
  end
end
