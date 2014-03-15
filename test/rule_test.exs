defmodule RuleTest do
  use ExUnit.Case
  import Life.Rule

  setup do
    under_populated = [["N","N","N","N","N","N"],
                       ["N","N","N","N","L","N"],
                       ["N","L","N","N","N","N"],
                       ["N","N","D","N","N","N"],
                       ["N","N","N","N","N","N"]]

    populated =      [["N","N","N","N","N","N"],
                      ["N","L","N","N","L","N"],
                      ["L","L","L","N","N","N"],
                      ["N","N","D","N","N","N"],
                      ["N","N","N","N","N","N"]]

    over_populated = [["N","N","N","N","N","N"],
                      ["N","L","N","N","L","N"],
                      ["L","L","L","N","N","N"],
                      ["L","N","D","N","N","N"],
                      ["N","N","N","N","N","N"]]

    reproduction = [["N","N","N","N","N","N"],
                    ["N","L","N","N","L","N"],
                    ["L","D","N","N","N","N"],
                    ["L","N","D","N","N","N"],
                    ["N","N","N","N","N","N"]]

    cell = Life.Map.Cell.new(location: {2,1})

    {:ok, [under_populated: under_populated,
           over_populated: over_populated,
           populated: populated,
           reproduction: reproduction,
           cell: cell]}
  end

  test "apply rules for under-populated cell", context do
    under_populated = Life.Map.CellDiff.new(location: {2,1},
                                            previous_state: "L",
                                            current_state: "L",
                                            next_state: "D")

    assert(apply_rules(context[:under_populated], context[:cell]) == under_populated)
  end

  test "apply rules for overcrowded cell", context do
    overcrowded = Life.Map.CellDiff.new(location: {2,1},
                                        previous_state: "L",
                                        current_state: "L",
                                        next_state: "D")

    assert(apply_rules(context[:under_populated], context[:cell]) == overcrowded)
  end

  test "apply rules for healthy cell", context do
    populated = Life.Map.CellDiff.new(location: {2,1},
                                      previous_state: "L",
                                      current_state: "L",
                                      next_state: "L")

    assert(apply_rules(context[:populated], context[:cell]) == populated)
  end

  test "apply rules for cellular reproduction", context do
    cell = Life.Map.Cell.new(location: {2,1}, state: "D")
    reproduction = Life.Map.CellDiff.new(location: {2,1},
                                         previous_state: "L",
                                         current_state: "D",
                                         next_state: "L")

    assert(apply_rules(context[:reproduction], cell) == reproduction)
  end
end