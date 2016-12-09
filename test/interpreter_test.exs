defmodule X3.Interpreter.Test do
  use ExUnit.Case

  import X3.Interpreter

  test "addition" do
    assert eval({:+, 1, 2}) == 3
  end

  test "subtraction" do
    assert eval({:-, 7, 2}) == 5
  end

  test "division" do
    assert eval({:/, 7, 2}) == 3.5
  end

  test "multiplication" do
    assert eval({:*, 7, 2}) == 14
  end

  test "equality" do
    refute eval({:==, 7, 2})
    assert eval({:==, 7, 7})
  end
end
