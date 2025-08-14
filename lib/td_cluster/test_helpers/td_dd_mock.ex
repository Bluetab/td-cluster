defmodule TdCluster.TestHelpers.TdDdMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def get_reference_dataset(expect, id, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :dd, TdDd.ReferenceData, :get, [arg]
                                                 when arg == id ->
      expected
    end)
  end

  def get_latest_structure_version(expect, id, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :dd,
                                                 TdDd.DataStructures,
                                                 :get_latest_version,
                                                 [arg, _]
                                                 when arg == id ->
      expected
    end)
  end

  def get_data_structure_by_external_id(expect, external_id, preload, expected, times) do
    IO.inspect("-------------------")
    IO.inspect(expect, label: "expect")
    IO.inspect(times, label: "times")
    IO.inspect(external_id)
    IO.inspect(preload)
    IO.inspect(expected)

    expect.(MockClusterHandler, :call, times, fn :dd,
                                                 TdDd.DataStructures,
                                                 :get_data_structure_by_external_id,
                                                 [arg_external_id, arg_preload] ->
      #  when arg_external_id == external_id and
      #         arg_preload == preload ->
      IO.inspect(arg_external_id)
      IO.inspect(arg_preload)
      expected
    end)
  end

  def log_start_stream(expect, args, count, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :dd,
                                                 TdDd.Search.Tasks,
                                                 :log_start_stream,
                                                 [args_args]
                                                 when args_args == args ->
      expected
    end)
  end

  def log_progress(expect, count, expected, times \\ 1) do
    expect.(MockClusterHandler, :call, times, fn :dd, TdDd.Search.Tasks, :log_progress, [_, arg]
                                                 when count == arg ->
      expected
    end)
  end
end
