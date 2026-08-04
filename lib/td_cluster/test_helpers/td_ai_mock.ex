defmodule TdCluster.TestHelpers.TdAiMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def available_resource_mapping(expect, _, expected) do
    expect.(MockClusterHandler, :call, 1, fn :ai,
                                             TdAi.FieldCompletion,
                                             :available_resource_mapping,
                                             _args ->
      expected
    end)
  end
end
