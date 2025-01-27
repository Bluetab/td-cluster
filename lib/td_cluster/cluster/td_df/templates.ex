defmodule TdCluster.Cluster.TdDf.Templates do
  @moduledoc """
  Cluster handler for TdDf Templates handling
  """
  alias TdCluster.Cluster.TdDf

  def get_by_name!(template_name) do
    {:ok, template} = TdDf.get_template_by_name!(template_name)
    template
  end

  def list_by_scope!(scope) do
    case TdDf.list_templates_by_scope(scope) do
      {:ok, templates} -> templates
      _ -> raise("fail to fetch templates")
    end
  end

  def get(template_id), do: TdDf.get_template(template_id)
end
