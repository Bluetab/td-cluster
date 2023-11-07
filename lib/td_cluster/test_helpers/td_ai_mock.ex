defmodule TdCluster.TestHelpers.TdAiMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def resource_field_completion(expect, {resource_type, resource_id, fields}, expected) do
    expect.(MockClusterHandler, :call, 1, fn :ai,
                                             TdAi.FieldCompletion,
                                             :resource_field_completion,
                                             _args ->
      expected
    end)
  end
end
