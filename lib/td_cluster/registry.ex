defmodule TdCluster.Registry do

  alias TdCluster.ProcessGroup

  def registre(groups) do
    Enum.each(groups, fn group ->
      :pg.join(ProcessGroup.get_scope(), group, self())
    end)
  end
end
