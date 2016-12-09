defmodule X3.Interpreter do
  @arithmaticals ~w(+ - / * ==)a

  def eval({operator, lhs, rhs}) when operator in @arithmaticals,
    do: apply(Kernel, operator, [lhs, rhs])

  def eval(unknown),
    do: raise RuntimeError, "Unknown expression: #{inspect unknown}"
end
