defmodule TdCluster.TestHelpers.TdDdMock do
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
                                             [arg, [:data_fields]]
                                             when arg == id ->
      expected
    end)
  end
end
