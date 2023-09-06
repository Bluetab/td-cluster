defmodule TdCluster.TestHelpers.TdDdMock do
  def get_reference_dataset(expect, id, expected) do
    expect.(MockClusterHandler, :call, 1, fn :dd, TdDd.ReferenceData, :get, [arg]
                                             when arg == id ->
      expected
    end)
  end
end
