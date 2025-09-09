defmodule TdCluster.TestHelpers.TdIeMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def get_ingest(expect, params, expected) do
    expect.(MockClusterHandler, :call, 1, fn :ie, TdIe.Ingests, :get_ingest!, [arg]
                                             when arg == params ->
      expected
    end)
  end
end
