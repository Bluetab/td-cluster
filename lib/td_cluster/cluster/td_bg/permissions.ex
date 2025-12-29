defmodule TdCluster.TdBg.Permissions do
  @moduledoc """
  Module to interact with the search of the bg cluster
  """

  alias TdBg.Permissions
  alias TdCluster.ClusterHandler

  def default_permissions do
    call_bg(Permissions, :get_default_permissions, [])
  end

  defp call_bg(module, function, args), do: ClusterHandler.call(:bg, module, function, args)
end
