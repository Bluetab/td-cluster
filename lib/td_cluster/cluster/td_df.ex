defmodule TdCluster.Cluster.TdDf do
  @moduledoc """
  Cluster handler for TdDf
  """

  alias TdCluster.ClusterHandler

  def get_template_by_name!(name), do: call_df(TdDf.Templates, :get_template_by_name!, [name])

  def list_templates_by_scope(scope),
    do: call_df(TdDf.Templates, :list_templates_by_scope, [scope])

  def get_template(template_id),
    do: call_df(TdDf.Templates, :get_template, [template_id])

  defp call_df(module, function, args), do: ClusterHandler.call(:df, module, function, args)
end
