defmodule RuleTest do
  use ExUnit.Case
  import Life.Rule

  setup do
    under_populated = [["N","N","N","N","N","N"],
                       ["N","N","N","N","L","N"],
                       ["N","L","N","N","N","N"],
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

    {:ok, [under_populated: under_populated,
           over_populated: over_populated,
           reproduction: reproduction] }
  end

  test "under-population", context do
    cell = Life.Map.Cell.new(location: {2,1})
    expected_state = Life.Map.CellDiff.new(location: {2,1}, previous_state: "L", current_state: "L", next_state: "D")
    assert(apply_under_population(context[:under_populated], cell) == expected_state)
  end

  # test "live", context do

  # end

   test "overcrowding", context do
     cell = Life.Map.Cell.new(location: {2,1})
     expected_state = Life.Map.CellDiff.new(location: {2,1}, previous_state: "L", current_state: "L", next_state: "D")
     assert(apply_over_population(context[:over_populated], cell) == expected_state)
   end

   test "reproduction", context do
     cell = Life.Map.Cell.new(location: {2,1}, state: "D")
     expected_state = Life.Map.CellDiff.new(location: {2,1},
                                            previous_state: "L",
                                            current_state: "D",
                                            next_state: "L")
     assert(apply_reproduction(context[:reproduction], cell) == expected_state)
   end
end