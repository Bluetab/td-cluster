defmodule TdCluster.Cluster.TdDd do
  @moduledoc """
  Cluster handler for TdDd
  """

  alias TdCluster.ClusterHandler

  def get_reference_dataset(id) do
    call_dd(TdDd.ReferenceData, :get, [id])
  end

  def get_latest_structure_version(id, opts \\ [:data_fields]) do
    call_dd(TdDd.DataStructures, :get_latest_version, [id, opts])
  end

  # bulk relation data_structure
  def get_data_structure_by_external_id(external_id, opts \\ []) do
    call_dd(TdDd.DataStructures, :get_data_structure_by_external_id, [external_id, opts])
  end

  # bulk relation implementation_ref
  def get_implementations_by_ref(implementation_ref, opts \\ []) do
    call_dd(TdDd.Implementations, :get_versions, [implementation_ref, opts])
  end

  def call_dd(module, function, args), do: ClusterHandler.call(:dd, module, function, args)
end
