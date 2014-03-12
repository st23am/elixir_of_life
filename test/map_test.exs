defmodule MapTest do
  use ExUnit.Case, async: true
  import Life.Map
  setup do 
    map_string  = """
                  LNLDLD
                  LNLNLD
                  LDNDLN
                  DLDDLN
                  LNLLLL
                  """

    map =  [["L","N","L","D","L","D"],
            ["L","N","L","N","L","D"],
            ["L","D","N","D","L","N"],
            ["D","L","D","D","L","N"],
            ["L","N","L","L","L","L"]]
    { :ok, [map: map, map_string: map_string] }
  end

  test "#from_string", context do
    assert(from_map_string(context[:map_string]) == context[:map])
  end

  test "#to_string", context do
    assert(to_map_string(context[:map]) == context[:map_string])
  end
  
  test "#cell_for_location", context do
    assert(cell_for_location(context[:map], {0,0}) == "L")
    assert(cell_for_location(context[:map], {1,4}) == "L")
    assert(cell_for_location(context[:map], {2,3}) == "D")
    assert(cell_for_location(context[:map], {3,1}) == "L")
    assert(cell_for_location(context[:map], {4,3}) == "L")
  end
  
  test "#neighbors_for_cell", context do
    neighbors = [{cell: "N", location: {1, 1}  },
                 {cell: "L", location: {1, 2}  }, 
                 {cell: "N", location: {1, 3}  }, 
                 {cell: "D", location: {2, 3}  }, 
                 {cell: "D", location: {3, 3}  }, 
                 {cell: "D", location: {3, 2}  }, 
                 {cell: "L", location: {3, 1}  }, 
                 {cell: "D", location: {2, 1}  },
                ]

    assert(neighbors_for_cell(context[:map], {2, 2}) == neighbors)
  end
end