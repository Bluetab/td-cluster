defmodule TdCluster.Cluster.TdAi.Embeddings do
  @moduledoc """
  Module to interact with tdai indices
  """

  alias TdCluster.Cluster

  def all(text) do
    Cluster.TdAi.call_ai(TdAi.Embeddings, :all, [text])
  end
end
