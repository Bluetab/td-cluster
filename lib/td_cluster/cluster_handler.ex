defmodule TdCluster.ClusterHandler do
  @moduledoc """
  Module for interacting with the Truedat Cluster
  """

  @typedoc """
  Service where you make the request
  """
  @type service :: atom()

  @typedoc "Module to execute in the service"
  @type call_module :: atom()

  @typedoc "module.func to execute in the service"
  @type func :: atom()

  @typedoc "A keyword list with arguments to pass to module.funtion"
  @type args :: Keyword.t()

  @type call_response :: {:ok, any()}
  @type detailed_call_response :: {:ok, any()} | {:error, any()}
  @type async_call_response :: :erpc.request_id() | :rpc.key()

  @doc """
  Execute function of another node
  """
  @callback call(service, module :: call_module, func, args) :: detailed_call_response
  @callback call!(service, module :: call_module, func, args) :: call_response
  @callback async_call(service, module :: call_module, func, args) :: async_call_response

  def call(service, module, func, args \\ []), do: impl().call(service, module, func, args)
  def call!(service, module, func, args \\ []), do: impl().call!(service, module, func, args)

  def async_call(service, module, func, args \\ []),
    do: impl().async_call(service, module, func, args)

  defp impl(),
    do: Application.get_env(:td_cluster, TdCluster.ClusterHandler, TdCluster.ClusterHandlerImpl)
end
