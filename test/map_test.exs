defmodule MapTest do
  use ExUnit.Case, async: true
  import Life.Map

  test "#from_string" do
    map = """
          LNLDLD
          LNLNLD
          LDNDLN
          DLDDLN
          LNLLLL
          """

    result = [["L","N","L","D","L","D"],
              ["L","N","L","N","L","D"],
              ["L","D","N","D","L","N"],
              ["D","L","D","D","L","N"],
              ["L","N","L","L","L","L"]]

    assert(from_map_string(map) == result)
  end
  
  test "#to_string" do
    result = """
             LNLDLD
             LNLNLD
             LDNDLN
             DLDDLN
             LNLLLL
             """ 
    map =    [["L","N","L","D","L","D"],
              ["L","N","L","N","L","D"],
              ["L","D","N","D","L","N"],
              ["D","L","D","D","L","N"],
              ["L","N","L","L","L","L"]]
    assert(to_map_string(map) == result)
  end
  
  test "#cell_for_location" do
    map =    [["L","N","L","D","L","D"],
              ["L","N","L","N","L","D"],
              ["L","D","N","D","L","N"],
              ["D","L","D","D","L","N"],
              ["L","N","L","L","L","L"]]

    assert(cell_for_location(map, {0,0}) == "L")
    assert(cell_for_location(map, {1,4}) == "L")
    assert(cell_for_location(map, {2,3}) == "D")
    assert(cell_for_location(map, {3,1}) == "L")
    assert(cell_for_location(map, {4,3}) == "L")
  end
  
  test "#neighbors_for_cell" do
    map =  [["L","N","L","D","L","D"],
            ["L","N","L","N","L","D"],
            ["L","D","X","D","L","N"],
            ["D","L","D","D","L","N"],
            ["L","N","L","L","L","L"]]

    neighbors = [{cell: "N", location: {1, 1}  },
                 {cell: "L", location: {1, 2}  }, 
                 {cell: "N", location: {1, 3}  }, 
                 {cell: "D", location: {2, 3}  }, 
                 {cell: "D", location: {3, 3}  }, 
                 {cell: "D", location: {3, 2}  }, 
                 {cell: "L", location: {3, 1}  }, 
                 {cell: "D", location: {2, 1}  }, 
                ]
    assert(neighbors_for_cell(map, {2, 2}) == neighbors)
  end
end