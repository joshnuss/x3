defmodule X3.Interpreter do
  def eval({op, lhs, rhs}) when op in ~w(+ - / * ==)a,
    do: apply(Kernel, op, [lhs, rhs])
end
