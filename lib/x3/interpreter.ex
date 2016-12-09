defmodule X3.Interpreter do
  @arithmaticals ~w(+ - / * ==)a

  def eval(list) when is_list(list) do
    Enum.reduce list, nil, fn expression, _acc ->
      eval(expression)
    end
  end

  def eval({operator, lhs, rhs}) when operator in @arithmaticals,
    do: apply(Kernel, operator, [eval(lhs), eval(rhs)])

  def eval({:declare, _name, value}),
    do: eval(value)

  def eval(literal) when is_number(literal),
    do: literal

  def eval(unknown),
    do: raise RuntimeError, "Unknown expression: #{inspect unknown}"
end
