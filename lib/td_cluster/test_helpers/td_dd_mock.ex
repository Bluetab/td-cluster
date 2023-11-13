defmodule TdCluster.TestHelpers.TdDdMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def get_reference_dataset(expect, id, expected) do
    expect.(MockClusterHandler, :call, 1, fn :dd, TdDd.ReferenceData, :get, [arg]
                                             when arg == id ->
      expected
    end)
  end

  def get_latest_structure_version(expect, id, expected) do
    expect.(MockClusterHandler, :call, 1, fn :dd,
                                             TdDd.DataStructures,
                                             :get_latest_version,
                                             [arg, _]
                                             when arg == id ->
      expected
    end)
  end
end
