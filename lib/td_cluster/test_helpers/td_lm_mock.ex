defmodule TdCluster.TestHelpers.TdLmMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def clone_relations(
        expect,
        original_source_id,
        new_source_id,
        relation_type,
        claims,
        expected,
        times \\ 1
      ) do
    expect.(MockClusterHandler, :call, times, fn :lm,
                                                 TdLm.Resources,
                                                 :clone_relations,
                                                 [
                                                   ^original_source_id,
                                                   ^new_source_id,
                                                   ^relation_type,
                                                   ^claims
                                                 ] ->
      expected
    end)
  end
end
