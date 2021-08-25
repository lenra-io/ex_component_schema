defmodule ExComponentSchema.Validator.Component do
  @moduledoc """
  `ExComponentSchema.Validator` implementation for custom `"comp"` attributes.
  """

  alias ExComponentSchema.Validator.Error

  @behaviour ExComponentSchema.Validator

  @impl ExComponentSchema.Validator
  def validate(_root, %{"type" => "component"}, {"comp", comp}, %{"comp" => comp}, _path) do
    IO.puts("VALID COMP property #{comp}")
    []
  end

  def validate(_root, %{"type" => "component"}, {"comp", comp}, %{"comp" => comp2}, _path) do
    [%Error{error: %Error.Component{expected: comp, actual: comp2}}]
  end

  def validate(_root, %{"type" => "component"}, {"comp", _}, _data, _path) do
    [%Error{error: %Error.Component{no_comp_property: true}}]
  end

  def validate(_root, _schema, _, _data, _path) do
    []
  end
end
