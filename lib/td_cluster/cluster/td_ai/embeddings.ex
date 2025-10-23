defmodule TdCluster.Cluster.TdAi.Embeddings do
  @moduledoc """
  Module to interact with td ai embeddings
  """

  alias TdCluster.Cluster

  def all(text, index_type) do
    Cluster.TdAi.call_ai(TdAi.Embeddings, :all, [text, index_type])
  end

  def generate_vector(text, index_type, collection_name \\ nil) do
    Cluster.TdAi.call_ai(TdAi.Embeddings, :generate_vector, [text, index_type, collection_name])
  end
end
