defmodule RuleTest do
  use ExUnit.Case
  import Life.Rule

  setup do
    under_populated = [[".",".",".",".",".","."],
                       [".",".",".",".","o","."],
                       [".","o",".",".",".","."],
                       [".",".","*",".",".","."],
                       [".",".",".",".",".","."]]

    populated =      [[".",".",".",".",".","."],
                      [".","o",".",".","o","."],
                      ["o","o","o",".",".","."],
                      [".",".","*",".",".","."],
                      [".",".",".",".",".","."]]

    over_populated = [[".",".",".",".",".","."],
                      [".","o",".",".","o","."],
                      ["o","o","o",".",".","."],
                      ["o",".","*",".",".","."],
                      [".",".",".",".",".","."]]

    reproduction = [[".",".",".",".",".","."],
                    [".","o",".",".","o","."],
                    ["o","*",".",".",".","."],
                    ["o",".","*",".",".","."],
                    [".",".",".",".",".","."]]

    cell = Life.Map.Cell.new(location: {2,1})

    {:ok, [under_populated: under_populated,
           over_populated: over_populated,
           populated: populated,
           reproduction: reproduction,
           cell: cell]}
  end

  test "apply rules for under-populated cell", context do
    under_populated = Life.Map.CellDiff.new(location: {2,1},
                                            previous_state: "o",
                                            current_state: "o",
                                            next_state: "*")

    assert(apply_rules(context[:under_populated], context[:cell]) == under_populated)
  end

  test "apply rules for overcrowded cell", context do
    overcrowded = Life.Map.CellDiff.new(location: {2,1},
                                        previous_state: "o",
                                        current_state: "o",
                                        next_state: "*")

    assert(apply_rules(context[:under_populated], context[:cell]) == overcrowded)
  end

  test "apply rules for healthy cell", context do
    populated = Life.Map.CellDiff.new(location: {2,1},
                                      previous_state: "o",
                                      current_state: "o",
                                      next_state: "o")

    assert(apply_rules(context[:populated], context[:cell]) == populated)
  end

  test "apply rules for cellular reproduction", context do
    cell = Life.Map.Cell.new(location: {2,1}, state: "*")
    reproduction = Life.Map.CellDiff.new(location: {2,1},
                                         previous_state: "o",
                                         current_state: "*",
                                         next_state: "o")

    assert(apply_rules(context[:reproduction], cell) == reproduction)
  end
end