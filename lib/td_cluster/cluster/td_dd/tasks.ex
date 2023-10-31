defmodule TdCluster.Cluster.TdDd.Tasks do
  @moduledoc """
  Cluster handler for TdDd reindex Tasks
  """
  alias TdCluster.Cluster

  def log_start(index) do
    Cluster.TdDd.call_dd(TdDd.Search.Tasks, :log_start, [self(), index])
  end

  def log_start_stream(count) do
    Cluster.TdDd.call_dd(TdDd.Search.Tasks, :log_start_stream, [self(), count])
  end

  def log_progress(chunk_size) do
    Cluster.TdDd.call_dd(TdDd.Search.Tasks, :log_progress, [self(), chunk_size])
  end

  def log_end do
    Cluster.TdDd.call_dd(TdDd.Search.Tasks, :log_end, [self()])
  end
end
