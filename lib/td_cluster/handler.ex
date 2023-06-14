defmodule TdCluster.Handler do

alias TdCluster.ProcessGroup

  def call(service, module, func, args \\ []) do
    pid = get_node(service)
    case :rpc.call(pid, module, func, args) do
      {:badrpc, error} ->
          {:error, error}
      response ->
          {:ok, response}
    end
  end

  def call!(service, module, func, args \\ []) do
    service
    |> get_node()
    |> :rpc.call(module, func, args)
  end


  def async_call!(service, module, func, args \\ []) do
    service
    |> get_node()
    |> :rpc.async_call(module, func, args)
  end

  defp get_node(service) do
    scope = ProcessGroup.get_scope()

    scope
    |> :pg.get_members(service)
    |> hd
    |> node
  end

end
