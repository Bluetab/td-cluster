defmodule TdCluster.TestHelpers.TdAuditMock.UploadJobs do
  @moduledoc """
  Mocks Clusters for tests
  """

  def create_job(expect, attrs, expected, times \\ 1) do
    expect.(MockClusterHandler, :call!, times, fn :audit,
                                                  TdAudit.UploadJobs,
                                                  :create_job,
                                                  [^attrs] ->
      expected
    end)
  end

  def create_pending(expect, job_id, expected \\ {:ok, nil}, times \\ 1) do
    expect.(MockClusterHandler, :call!, times, fn :audit,
                                                  TdAudit.UploadJobs,
                                                  :create_pending,
                                                  [^job_id] ->
      expected
    end)
  end

  def create_error(expect, job_id, response, expected \\ {:ok, nil}, times \\ 1) do
    expect.(MockClusterHandler, :call!, times, fn :audit,
                                                  TdAudit.UploadJobs,
                                                  :create_error,
                                                  [^job_id, resp] ->
      assert_maps_includes(response, resp)
      expected
    end)
  end

  def create_info(expect, job_id, response, expected \\ {:ok, nil}, times \\ 1) do
    expect.(MockClusterHandler, :call!, times, fn :audit,
                                                  TdAudit.UploadJobs,
                                                  :create_info,
                                                  [^job_id, resp] ->
      assert_maps_includes(response, resp)
      expected
    end)
  end

  def create_failed(expect, job_id, message, expected \\ {:ok, nil}, times \\ 1) do
    expect.(MockClusterHandler, :call!, times, fn :audit,
                                                  TdAudit.UploadJobs,
                                                  :create_failed,
                                                  [^job_id, ^message] ->
      expected
    end)
  end

  def create_started(expect, job_id, expected \\ {:ok, nil}, times \\ 1) do
    expect.(MockClusterHandler, :call!, times, fn :audit,
                                                  TdAudit.UploadJobs,
                                                  :create_started,
                                                  [^job_id] ->
      expected
    end)
  end

  def create_completed(expect, job_id, response, expected \\ {:ok, nil}, times \\ 1) do
    expect.(MockClusterHandler, :call!, times, fn :audit,
                                                  TdAudit.UploadJobs,
                                                  :create_completed,
                                                  [^job_id, ^response] ->
      expected
    end)
  end

  defp assert_maps_includes(expected, actual) when is_map(expected) and is_map(actual) do
    Enum.each(expected, fn {key, val} ->
      case Map.fetch(actual, key) do
        {:ok, actual_val} ->
          if is_map(val) and is_map(actual_val) do
            assert_maps_includes(val, actual_val)
          else
            if actual_val != val do
              raise "Expected key #{inspect(key)} with value #{inspect(val)}, got #{inspect(actual_val)}"
            end
          end

        :error ->
          raise "Expected key #{inspect(key)} not found in map #{inspect(actual)}"
      end
    end)
  end
end
