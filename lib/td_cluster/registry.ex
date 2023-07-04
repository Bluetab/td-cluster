defmodule TdCluster.Registry do
  @moduledoc """
  Implement function to register us node in groups passed by config
  """

  alias TdCluster.ProcessGroup

  def register(groups) do
    Enum.each(groups, fn group ->
      :pg.join(ProcessGroup.get_scope(), group, self())
    end)
  end
end
