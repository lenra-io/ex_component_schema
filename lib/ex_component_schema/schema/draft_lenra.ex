defmodule ExComponentSchema.Schema.DraftLenra do
  @spec schema() :: ExComponentSchema.object()
  def schema, do: Poison.decode!(File.read!("priv/static/draft-lenra.json"))

  @spec version() :: integer()
  def version, do: 4
end
