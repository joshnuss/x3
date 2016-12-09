defmodule X3.Interpreter.Test do
  use ExUnit.Case

  import X3.Interpreter

  test "addition",
    do: assert eval({:+, 1, 2}) == 3

  test "subtraction",
    do: assert eval({:-, 7, 2}) == 5

  test "division",
    do: assert eval({:/, 7, 2}) == 3.5

  test "multiplication",
    do: assert eval({:*, 7, 2}) == 14

  test "equality" do
    refute eval({:==, 7, 2})
    assert eval({:==, 7, 7})
  end

  test "raises when unknown expression" do
    assert_raise RuntimeError, fn ->
      eval(:saywhatnow)
    end
  end
end
