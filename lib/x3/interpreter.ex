defmodule X3.Interpreter do
  @arithmaticals ~w(+ - / * ==)a

  def eval(expression, binding \\ %{}) do
    {value, _binding} = do_eval(expression, binding)
    value
  end

  defp do_eval(list, binding) when is_list(list) do
    Enum.reduce list, {nil, binding}, fn expression, {_last, binding} ->
      do_eval(expression, binding)
    end
  end

  defp do_eval({operator, lhs, rhs}, binding) when operator in @arithmaticals do
    arguments = [
      eval(lhs, binding),
      eval(rhs, binding)
    ]

    {apply(Kernel, operator, arguments), binding}
  end

  defp do_eval({:declare, name, value}, binding) do
    {literal, _binding} = do_eval(value, binding)

    {literal, Map.put(binding, name, literal)}
  end

  defp do_eval({:ref, name}, binding),
    do: {Map.fetch!(binding, name), binding}

  defp do_eval(literal, binding) when is_number(literal),
    do: {literal, binding}

  defp do_eval(unknown, _binding),
    do: raise RuntimeError, "Unknown expression: #{inspect unknown}"
end
