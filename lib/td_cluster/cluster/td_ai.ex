defmodule TdCluster.Cluster.TdAi do
  @moduledoc """
  Cluster handler for TdAi
  """

  alias TdCluster.ClusterHandler

  def resource_field_completion(resource_type, resource_id, fields, opts \\ []) do
    call_ai(TdAi.FieldCompletion, :resource_field_completion, [
      resource_type,
      resource_id,
      fields,
      opts
    ])
  end

  def available_resource_mapping(resource_type, selector) do
    call_ai(TdAi.FieldCompletion, :available_resource_mapping, [resource_type, selector])
  end

  def call_ai(module, function, args), do: ClusterHandler.call(:ai, module, function, args)
end
