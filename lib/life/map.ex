defmodule Life.Map do
  defrecord Cell, state: "L", location: nil, previous_state: "L"
  defrecord CellDiff, location: nil, previous_state: nil, current_state: nil, next_state: nil

  def from_map_string(string) do
    String.split(string, %r(\n))
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&(String.graphemes(&1)))
  end
  
  def to_map_string(map) do
    Enum.map(map, &(Enum.join(&1)))
    |> Enum.map(&("#{&1}\n"))
    |> Enum.join
  end
  
  def cell_for_location(map, {x, y}) do
    Enum.at(map, x) |> Enum.at(y)
  end

  def neighbors_for_cell(map, {x, y}) do
    neighbors = [{(x - 1), (y - 1)}, #top_left
                 {(x - 1), (y    )}, #top_center
                 {(x - 1), (y + 1)}, #top_right
                 {(x    ), (y + 1)}, #right
                 {(x + 1), (y + 1)}, #bottom_right
                 {(x + 1), (y    )}, #bottom_middle
                 {(x + 1), (y - 1)}, #bottom_left
                 {(x    ), (y - 1)}] #left

    Enum.map(neighbors, &(Cell.new(state: cell_for_location(map, &1), location: &1)))
  end
end