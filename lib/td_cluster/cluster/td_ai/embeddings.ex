defmodule TdCluster.Cluster.TdAi.Embeddings do
  @moduledoc """
  Module to interact with td ai embeddings
  """

  alias TdCluster.Cluster

  def all(text) do
    Cluster.TdAi.call_ai(TdAi.Embeddings, :all, [text])
  end

  def generate_vector(text, collection_name \\ nil) do
    Cluster.TdAi.call_ai(TdAi.Embeddings, :generate_vector, [text, collection_name])
  end
end
