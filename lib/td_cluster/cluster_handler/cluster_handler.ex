defmodule TdCluster.ClusterHandler do
  @moduledoc """
  This module provides an API for calling functions on other nodes and retrieving the result. It is
  done in accordance with the ClusterHandlerBehaviour behavior.

  The TdCluster.ClusterHandlerBehaviour module injects the implementation functions into this
  module. By default, the implementation is provided by TdCluster.ClusterHandlerImplementation,
  but you can use another module as implementation if it implements
  TdCluster.ClusterHandlerBehaviour behavior

  This allows defining alternative implementations for connecting with the cluster, or even using
  mock modules for testing purposes

  The module that will be used as the implementation needs to be configured as follows:

  config :td_cluster, :cluster_handler, MyClusterHandlerImplementation
  """
  use TdCluster.ClusterHandlerBehaviour
end
