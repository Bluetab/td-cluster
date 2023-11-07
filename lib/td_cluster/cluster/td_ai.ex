defmodule TdCluster.Cluster.TdAi do
  @moduledoc """
  Cluster handler for TdAi
  """

  alias TdCluster.ClusterHandler

  def resource_field_completion(resource_type, resource_id, fields) do
    call_ai(TdAi.FieldCompletion, :resource_field_completion, [resource_type, resource_id, fields])
  end

  def call_ai(module, function, args), do: ClusterHandler.call(:ai, module, function, args)
end
