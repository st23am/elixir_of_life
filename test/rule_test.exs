defmodule RuleTest do
  use ExUnit.Case
  import Life.Rule
  import Life.Map

  setup do
    under_populated_current = [["N","N","N","N","N","N"],
                               ["N","N","N","N","L","N"],
                               ["N","L","N","N","N","N"],
                               ["N","N","D","N","N","N"],
                               ["N","N","N","N","N","N"]]

    {:ok, [under_populated_current: under_populated_current] }
  end

  test "under-population", context do
    # 2,1
    cell = Life.Map.Cell.new(location: {2,1})
    expected_state = Life.Map.CellDiff.new(location: {2,1}, previous_state: "L", current_state: "L", next_state: "D")
    assert(apply_under_population(context[:under_populated_current], cell) == expected_state)
  end

  # test "live", context do

  # end

  # test "overcrowding", context do

  # end

  # test "reproduction", context do

  # end
end