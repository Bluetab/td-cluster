defmodule TdCluster.Strategy do
  @moduledoc """
  Strategy to handle microservices elixir cluster
  """

  use GenServer
  use Cluster.Strategy

  alias Cluster.Strategy.State
  alias TdCluster.Registry

  @default_polling_interval 5_000

  @impl true
  def start_link(args), do: GenServer.start_link(__MODULE__, args)

  @impl true
  def init([%State{meta: nil} = state]) do
    init([%State{state | :meta => MapSet.new()}])
  end

  def init([%State{config: config} = state]) do
    groups = Keyword.fetch!(config, :groups)
    Registry.registre(groups)
    {:ok, load(state), 0}
  end

  @impl true
  def handle_info(:load, state) do
    {:noreply, load(state)}
  end

  def handle_info({:nodedown, node}, %State{meta: meta} = state) do
    Node.monitor(node, false)

    new_node_list =
      [node]
      |> MapSet.new()
      |> then(&MapSet.difference(meta, &1))

    new_state = %State{state | meta: new_node_list}

    Process.send_after(self(), :load, get_polling_interval(state))

    {:noreply, new_state}
  end

  def handle_info(_action, state) do
    {:noreply, state}
  end

  defp load(%State{topology: topology, meta: meta} = state) do
    nodes = MapSet.new(get_nodes(state))
    connected_nodes = MapSet.new(Node.list())

    monitor_indirect_connected_nodes(connected_nodes, meta)

    case MapSet.to_list(MapSet.difference(nodes, connected_nodes)) do
      [] ->
        meta

      nodes_to_connect ->
        connect_nodes(topology, state, nodes_to_connect)
    end

    %State{state | meta: MapSet.new(Node.list())}
  end

  defp connect_nodes(topology, state, nodes) do
    case Cluster.Strategy.connect_nodes(topology, state.connect, state.list_nodes, nodes) do
      :ok ->
        Enum.each(nodes, &Node.monitor(&1, true))
        MapSet.new(nodes)

      {:error, nodes_no_connected} ->
        Process.send_after(self(), :load, get_polling_interval(state))
        nodes = MapSet.new(nodes)

        Enum.reduce(nodes_no_connected, nodes, fn {n, _}, acc ->
          MapSet.delete(acc, n)
        end)
    end
  end

  defp get_nodes(state) do
    node_template = get_node_template(state)
    services = get_services(state)
    Enum.map(services, &apply_template(node_template, &1))
  end

  defp apply_template(template, service) do
    {:ok, hostname} = :inet.gethostname()

    map = %{
      "service" => Atom.to_string(service),
      "hostname" => hostname
    }

    ~r/{{([a-z]+)?}}/
    |> Regex.replace(template, fn _, match -> map[match] end)
    |> String.to_atom()
  end

  defp get_polling_interval(%State{config: config}) do
    Keyword.get(config, :polling_interval, @default_polling_interval)
  end

  defp get_node_template(%State{config: config}) do
    Keyword.fetch!(config, :node_template)
  end

  defp get_services(%State{config: config}) do
    Keyword.fetch!(config, :services)
  end

  defp monitor_indirect_connected_nodes(nodes_connected, nodes_monitored) do
    nodes_connected
    |> MapSet.difference(nodes_monitored)
    |> MapSet.to_list()
    |> Enum.each(&Node.monitor(&1, true))
  end
end
