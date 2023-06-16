defmodule TdCluster.Registry do
  @moduledoc """
  Implement function to registre us node in groups passed by config
  """

  alias TdCluster.ProcessGroup

  def registre(groups) do
    Enum.each(groups, fn group ->
      :pg.join(ProcessGroup.get_scope(), group, self())
    end)
  end
end
