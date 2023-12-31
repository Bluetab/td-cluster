defmodule TdCluster.ClusterHandlerImpl do
  @moduledoc """
  ClusterHandler implementation
  """

  alias TdCluster.ProcessGroup

  @behaviour TdCluster.ClusterHandler

  @impl true
  def call(service, module, func, args \\ []) do
    service
    |> get_node()
    |> :rpc.call(module, func, args)
    |> case do
      {:badrpc, error} ->
        {:error, error}

      response ->
        {:ok, response}
    end
  end

  @impl true
  def call!(service, module, func, args \\ []) do
    service
    |> get_node()
    |> :rpc.call(module, func, args)
    |> case do
      {:badrpc, error} ->
        raise TdCluster.ClusterError, service: service, error: error

      response ->
        response
    end
  end

  @impl true
  def async_call(service, module, func, args \\ []) do
    service
    |> get_node()
    |> :rpc.async_call(module, func, args)
  end

  defp get_node(service) do
    scope = ProcessGroup.get_scope()

    case :pg.get_members(scope, service) do
      [] -> nil
      [pid | _] -> node(pid)
    end
  end
end
