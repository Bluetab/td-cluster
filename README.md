# td-cluster
Truedat Cluster modules. Provides modules for managing elixir nodes with
microservices approach

## Configuration

### Files

**config/config.exs**
```elixir

config :td_cluster,
  scope: :truedat,
  topologies: [
    truedat: [
      strategy: TdCluster.Strategy,
      config: [
        node_template: System.get_env("RELEASE_NODE_TEMPLATE", "{{service}}@{{hostname}}"),
        services: [
          :dd,
          :qx
        ],
        groups: [:dd],
        polling_interval: 5_000
      ]
    ]
  ]
```

#### td_cluster/scope:

The scope of the process group to which you want your node to belong. This
configuration is in accordance with the following
[documentation](https://www.erlang.org/doc/man/pg.html).
You can replace `:truedat` for another scope

#### td_cluster/topologies/truedat/config

  - **node_template**: It is a text string with the template that forms the node
    names in the cluster
  - **services**: Services you want to connect with
  - **groups**: Process groups you want your node to belong to
  - **polling_interval**: The frequency with which connection attempts will be
    retried for nodes that are not connected, expressed in milliseconds

**application.ex**
```elixir
children = [
  # ...
  TdCluster.Supervisor,
]
```

### Environment Variables
  - **RELEASE_NODE_TEMPLATE**: It is a text string with the template that forms
    the node names in the cluster. It can have the following wildcards that
    will be replaced by the corresponding values:
      - service: Service name of the node
      - hostname: Hostname of machine that will execute the node

    The wildcards will be enclosed in {{service}}

    **Examples:**

      For local:
      - service: dd
      - hostname: MYHOSTNAME
      - RELEASE_NODE_TEMPLATE: "{{service}}@{{hostname}}"

      My node name will be dd@MYHOSTNAME

    For kubernetes:
      - service: dd
      - RELEASE_NODE_TEMPLATE: "truedat@{{service}}.default.svc.cluster.local"

      My node name will be truedat@dd.default.svc.cluster.local

## Mock ClusterHandler for testing

You can set up an implementation module for TdCluster.ClusterHandler. This
module should be defined with the behaviour TdCluster.ClusterHandlerBehaviour
and can be set as the attribute :cluster_handler in the :td_cluster
configuration. This allows us to create a mock using Mox that implements that
behaviour and use it to replace TdCluster.ClusterHandler at runtime.

To create the Mock for TdCluster.ClusterHandler, the following files need to
be configured:

Install Mox adding this deps to mix.exs

**mix.exs**
```elixir
# ...
defp deps do
  [
    # ...
    {:mox, "~> 1.0", only: :test},
  ]
end
```

Import Mox for all test cases

**test/support/conn_case.ex**
```elixir
# ...
using do
  quote do
    # ...
    import Mox
    # ...
  end
end
```

Create Mock of ClusterHandler using TdCluster.ClusterHandlerBehaviour

**test/test_helper.exs**
```elixir
# ...
ExUnit.start()
Mox.defmock(MockClusterHandler, for: TdCluster.ClusterHandlerBehaviour)
# ...
```

Replace TdCluster.ClusterHandler implementation by MockClusterHandler

**config/test.exs**
```elixir
# ...
config :td_cluster, :cluster_handler, MockClusterHandler
# ...
```

You can use the following line in your tests to replace the result of the call
to the call function of TdCluster.HandleCluster with a predefined value:

```elixir
expect(
  MockClusterHandler,
  :call,
  fn _service, _module, _func, _args -> {:ok, data_structures} end
)
```

## Running the tests

Run all aplication tests with `mix test`.
