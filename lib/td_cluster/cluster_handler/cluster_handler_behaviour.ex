defmodule TdCluster.ClusterHandlerBehaviour do
  @moduledoc """
  Behaviour for interacting with the Truedat Cluster
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

  defmacro __using__(_opts) do
    module_to_import =
      Application.get_env(:td_cluster, :cluster_handler, TdCluster.ClusterHandlerImplementation)

    quote do
      defdelegate call(service, module, func, args), to: unquote(module_to_import)
      defdelegate call!(service, module, func, args), to: unquote(module_to_import)
      defdelegate async_call(service, module, func, args), to: unquote(module_to_import)
    end
  end
end
