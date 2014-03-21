defmodule MapTest do
  use ExUnit.Case
  import Life.Map
  setup do
    map_string  = """
                  LNLDLD
                  LNLNLD
                  LDNDLN
                  DLDDLN
                  LNLLLL
                  """
    small_map = [["L","N","D"],
                 ["L","L","L"],
                 ["N","D","N"]]

    map =  [["L","N","L","D","L","D"],
            ["L","N","L","N","L","D"],
            ["L","D","N","D","L","N"],
            ["D","L","D","D","L","N"],
            ["L","N","L","L","L","L"]]

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
    cells = [Life.Map.Cell[state: "L", location: {0, 0}, previous_state: "L"],
             Life.Map.Cell[state: "N", location: {0, 1}, previous_state: "L"],
             Life.Map.Cell[state: "D", location: {0, 2}, previous_state: "L"],
             Life.Map.Cell[state: "L", location: {1, 0}, previous_state: "L"],
             Life.Map.Cell[state: "L", location: {1, 1}, previous_state: "L"],
             Life.Map.Cell[state: "L", location: {1, 2}, previous_state: "L"],
             Life.Map.Cell[state: "N", location: {2, 0}, previous_state: "L"],
             Life.Map.Cell[state: "D", location: {2, 1}, previous_state: "L"],
             Life.Map.Cell[state: "N", location: {2, 2}, previous_state: "L"]]

    assert(cells(context[:small_map]) == cells)
  end

  test "#cell_for_location", context do
    assert(cell_for_location(context[:map], {0,0}) == "L")
    assert(cell_for_location(context[:map], {1,4}) == "L")
    assert(cell_for_location(context[:map], {2,3}) == "D")
    assert(cell_for_location(context[:map], {3,1}) == "L")
    assert(cell_for_location(context[:map], {4,3}) == "L")
  end

  test "#neighbors_for_cell", context do
    neighbors = [Life.Map.Cell[state: "N", location: {1, 1} ],
                 Life.Map.Cell[state: "L", location: {1, 2} ],
                 Life.Map.Cell[state: "N", location: {1, 3} ],
                 Life.Map.Cell[state: "D", location: {2, 3} ],
                 Life.Map.Cell[state: "D", location: {3, 3} ],
                 Life.Map.Cell[state: "D", location: {3, 2} ],
                 Life.Map.Cell[state: "L", location: {3, 1} ],
                 Life.Map.Cell[state: "D", location: {2, 1} ],
                ]

    assert(neighbors_for_cell(context[:map], {2, 2}) == neighbors)
  end
end