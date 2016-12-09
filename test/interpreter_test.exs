defmodule X3.Interpreter.Test do
  use ExUnit.Case

  import X3.Interpreter

  describe "literal" do
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
  end

  describe "sub-expression" do
    test "addition",
      do: assert eval({:+, {:+, 2, 3}, {:+, 4, 5}}) == 14

    test "subtraction",
      do: assert eval({:-, {:+, 2, 3}, {:+, 4, 5}}) == -4

    test "division",
      do: assert eval({:/, {:+, 4, 5}, {:+, 1, 1}}) == 4.5

    test "multiplication",
      do: assert eval({:*, {:+, 4, 5}, {:+, 3, 1}}) == 36

    test "equality" do
      refute eval({:==, {:+, 3, 4}, {:+, 2, 2}})
      assert eval({:==, {:+, 3, 4}, {:+, 4, 3}})
    end
  end

  describe "variable" do
    test "literal declaration",
      do: assert eval({:declare, :x, 100}) == 100

    test "expression declaration",
      do: assert eval({:declare, :x, {:+, 25, 75}}) == 100

    test "reference" do
      expressions = [
        {:declare, :x, 10},
        {:ref, :x}
      ]

      assert eval(expressions) == 10
    end
  end

  describe "list of expressions" do
    test "more than zero" do
      expressions = [
        {:+, 5, 10},
        {:+, 10, 20},
      ]

      assert eval(expressions) == 30
    end

    test "empty",
      do: assert eval([]) == nil
  end

  test "raises when unknown expression" do
    assert_raise RuntimeError, fn ->
      eval(:saywhatnow)
    end
  end
end
