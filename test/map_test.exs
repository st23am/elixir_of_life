defmodule MapTest do
  use ExUnit.Case
  import Life.Map
  setup do
    map_string  = """
                  o.o*o*
                  o.o.o*
                  o*.*o.
                  *o**o.
                  o.oooo
                  """
    small_map = [["o",".","*"],
                 ["o","o","o"],
                 [".","*","."]]


    map =  [["o",".","o","*","o","*"],
            ["o",".","o",".","o","*"],
            ["o","*",".","*","o","."],
            ["*","o","*","*","o","."],
            ["o",".","o","o","o","o"]]

    map2 =  [["o","*","*","*","*","*","*","o","*"],
             ["o","o","*","o","*","*","*","o","*"],
             ["o","*","*","*","*","*","*","*","o"],
             ["o","o","*","o","*","*","o","*","*"],
             ["o","*","*","*","*","*","*","o","*"],
             ["*","o","*","*","o","*","*","*","o"],
             ["o","*","*","*","*","*","*","o","*"],
             ["o","*","*","*","*","*","*","o","*"],
             ["o","*","*","*","*","*","*","o","*"],
             ["o","*","*","*","*","*","*","o","*"],
             ["o","*","*","*","*","*","*","o","*"],
             ["o","*","*","*","*","*","*","o","*"]]

    { :ok, [ map: map,
             small_map: small_map,
             map_string: map_string ] }
  end

  test "#from_string", context do
    assert(from_map_string(context[:map_string]) == context[:map])
  end

  test "#to_string", context do
    assert(to_map_string(context[:map]) == context[:map_string])
  end

  test "#cells", context do
    cells = [Life.Map.Cell[state: "o", location: {0, 0}, previous_state: "o"],
             Life.Map.Cell[state: "*", location: {0, 2}, previous_state: "o"],
             Life.Map.Cell[state: "o", location: {1, 0}, previous_state: "o"],
             Life.Map.Cell[state: "o", location: {1, 1}, previous_state: "o"],
             Life.Map.Cell[state: "o", location: {1, 2}, previous_state: "o"],
             Life.Map.Cell[state: "*", location: {2, 1}, previous_state: "o"]]

    assert(cells(context[:small_map]) == cells)
  end
  test "#evolve", context do
    cell_diffs = [Life.Map.CellDiff[location: {0,0},
                                    previous_state: "o",
                                    current_state: "o",
                                    next_state: "o"],

                  Life.Map.CellDiff[location: {0,2},
                                    previous_state: "o",
                                    current_state: "*",
                                    next_state: "o"],

                  Life.Map.CellDiff[location: {1,0},
                                    previous_state: "o",
                                    current_state: "o",
                                    next_state: "o"],

                  Life.Map.CellDiff[location: {1,1},
                                    previous_state: "o",
                                    current_state: "o",
                                    next_state: "o"],

                  Life.Map.CellDiff[location: {1,2},
                                    previous_state: "o",
                                    current_state: "o",
                                    next_state: "o"],

                  Life.Map.CellDiff[location: {2,1},
                                    previous_state: "o",
                                    current_state: "*",
                                    next_state: "o"],
                 ]
    evolved_map = [["o", ".", "o"], ["o", "o", "o"], [".", "o", "."]]

    assert(evolve(cell_diffs, context[:small_map]) == evolved_map)
  end

  test "#cell_for_location", context do
    assert(cell_for_location(context[:map], {0,0}) == Life.Map.Cell[state: "o", location: {0,0}])
    assert(cell_for_location(context[:map], {1,4}) == Life.Map.Cell[state: "o", location: {1,4}])
    assert(cell_for_location(context[:map], {2,3}) == Life.Map.Cell[state: "*", location: {2,3}])
    assert(cell_for_location(context[:map], {3,1}) == Life.Map.Cell[state: "o", location: {3,1}])
    assert(cell_for_location(context[:map], {4,3}) == Life.Map.Cell[state: "o", location: {4,3}])
  end

  test "#neighbors_for_cell", context do
    neighbors = [Life.Map.Cell[state: ".", location: {1, 1} ],
                 Life.Map.Cell[state: "o", location: {1, 2} ],
                 Life.Map.Cell[state: ".", location: {1, 3} ],
                 Life.Map.Cell[state: "*", location: {2, 3} ],
                 Life.Map.Cell[state: "*", location: {3, 3} ],
                 Life.Map.Cell[state: "*", location: {3, 2} ],
                 Life.Map.Cell[state: "o", location: {3, 1} ],
                 Life.Map.Cell[state: "*", location: {2, 1} ],
                ]

    assert(neighbors_for_cell(context[:map], {2, 2}) == neighbors)
  end
end