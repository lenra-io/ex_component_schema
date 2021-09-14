defmodule ExComponentSchema.Validator.FirstOfComp do
  @moduledoc """
  `ExComponentSchema.Validator` implementation for `"oneOf"` attributes.

  See:

  """

  alias ExComponentSchema.Validator
  alias ExComponentSchema.Validator.Error

  @behaviour ExComponentSchema.Validator

  @impl ExComponentSchema.Validator
  def validate(root, _, {"firstOfComp", first_of_comp}, data, path) do
    with [] <- do_validate(root, first_of_comp, data, path) do
      callback = Application.fetch_env!(:ex_component_schema, :on_comp_succeed)
      callback.(data)
      []
    end
  end

  def validate(_, _, _, _, _) do
    []
  end

  defp do_validate(root, first_of_comp, data, path) do
    first_of_comp
    |> Enum.reduce_while([], fn
      schema, _ ->
        case Validator.validation_errors(root, schema, data, path) do
          [] ->
            {:halt, []}

          errors ->
            case get_component_error(errors) do
              nil ->
                {:halt, errors}

              %Error{error: %Error.Component{no_comp_property: true}} = e ->
                {:halt, List.wrap(e)}

              e ->
                {:cont, List.wrap(e)}
            end
        end
    end)
  end

  defp get_component_error(errors) do
    Enum.find(errors, fn
      %Error{error: %Error.Component{}} -> true
      _ -> false
    end)
  end
end
