defmodule X3.Interpreter do
  @arithmaticals ~w(+ - / * ==)a

  def eval({operator, lhs, rhs}) when operator in @arithmaticals,
    do: apply(Kernel, operator, [eval(lhs), eval(rhs)])

  def eval({:declare, _name, value}),
    do: value

  def eval(literal) when is_number(literal),
    do: literal

  def eval(unknown),
    do: raise RuntimeError, "Unknown expression: #{inspect unknown}"
end
