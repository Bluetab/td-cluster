defmodule TdCluster.Cluster.TdAudit.UploadJobs do
  @moduledoc """
  Cluster handler for TdAudit Upload Jobs handling
  """
  alias TdCluster.Cluster

  def create_job(attrs) do
   Cluster.TdAudit.call_audit!(TdAudit.UploadJobs, :create_job, [attrs])
  end

  def create_pending(job_id) do
    Cluster.TdAudit.call_audit!(TdAudit.UploadJobs, :create_pending, [job_id])
  end

  def create_error(job_id, response) do
    Cluster.TdAudit.call_audit!(TdAudit.UploadJobs, :create_error, [job_id, response])
  end

  def create_info(job_id, response) do
    Cluster.TdAudit.call_audit!(TdAudit.UploadJobs, :create_info, [job_id, response])
  end

  def create_failed(job_id, message) do
    Cluster.TdAudit.call_audit!(TdAudit.UploadJobs, :create_failed, [job_id, message])
  end

  def create_started(job_id) do
    Cluster.TdAudit.call_audit!(TdAudit.UploadJobs, :create_started, [job_id])
  end

  def create_completed(job_id, response) do
    Cluster.TdAudit.call_audit!(TdAudit.UploadJobs, :create_completed, [job_id, response])
  end
end
