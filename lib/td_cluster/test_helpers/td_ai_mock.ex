defmodule TdCluster.TestHelpers.TdAiMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def resource_field_completion(expect, _, expected) do
    expect.(MockClusterHandler, :call, 1, fn :ai,
                                             TdAi.FieldCompletion,
                                             :resource_field_completion,
                                             _args ->
      expected
    end)
  end

  def available_resource_mapping(expect, _, expected) do
    expect.(MockClusterHandler, :call, 1, fn :ai,
                                             TdAi.FieldCompletion,
                                             :available_resource_mapping,
                                             _args ->
      expected
    end)
  end
end
