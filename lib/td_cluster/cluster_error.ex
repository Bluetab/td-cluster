defmodule TdCluster.ClusterError do
  defexception message: "Some error ocurred with cluster"

  @impl true
  def exception(service: service, error: {:EXIT, {:undef, [{module, func, args, _}]}}) do
    arity = length(args)
    func_str = "#{Atom.to_string(module)}.#{Atom.to_string(func)}/#{arity}"
    msg = "Error calling node #{service}. Reason the function #{func_str} is undefined"
    %TdCluster.ClusterError{message: msg}
  end

  @impl true
  def exception(service: service, error: error) do
    msg =
      "Error connecting with #{Atom.to_string(service)} node. Reason: #{Atom.to_string(error)}"

    %TdCluster.ClusterError{message: msg}
  end
end
