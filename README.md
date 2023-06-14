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

## Running the tests

Run all aplication tests with `mix test`.
