defmodule ExComponentSchema.Validator.MultipleOf do
  @moduledoc """
  `ExComponentSchema.Validator` implementation for `"multipleOf"` attributes.

  See:

  """

  alias ExComponentSchema.Validator.Error

  @behaviour ExComponentSchema.Validator

  @impl ExComponentSchema.Validator
  def validate(_, _, {"multipleOf", multiple_of}, data, _) do
    do_validate(multiple_of, data)
  end

  def validate(_, _, _, _, _) do
    []
  end

  defp do_validate(_, 0) do
    []
  end

  defp do_validate(0, _) do
    # "Expected multipleOf to be > 1."
    [%Error{error: %Error.MultipleOf{expected: 0}}]
  end

  defp do_validate(_, data) when not is_number(data) do
    []
  end

  defp do_validate(multiple_of, data) when is_number(multiple_of) and is_number(data) do
    if Float.ceil(data / multiple_of) == Float.floor(data / multiple_of) do
      []
    else
      [%Error{error: %Error.MultipleOf{expected: multiple_of}}]
    end
  end

  defp do_validate(_, _) do
    []
  end
end
