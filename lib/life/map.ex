defmodule Life.Map do

  defrecord Cell, state: "o", location: nil, previous_state: "o"
  defrecord CellDiff, location: nil, previous_state: nil, current_state: nil, next_state: nil
  defrecord Generation, map: nil, cells: nil

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

  def evolve(cell_diffs, map) do
    Enum.reduce(cell_diffs, map, fn (cell_diff, map) ->
                              apply_cell_diff(map, cell_diff)
                         end)
  end

  def apply_cell_diff(map, cell_diff) do
    {x, y} = cell_diff.location
    row = List.update_at(Enum.at(map, x), y, fn (row) -> cell_diff.next_state end)
    List.update_at(map, x, fn (_) -> row end)
  end

  def cells(map) do
    Enum.with_index(map)
    |> Enum.map(&(tuple_to_list(&1)))
    |> Enum.reduce([], fn(row, acc) ->
                    Enum.concat(cells_for_row(row), acc)
                  end)
    |> Enum.reverse
  end

  def cells_for_row([row | row_num]) do
    Enum.with_index(row)
    |> Enum.map(&(tuple_to_list(&1)))
    |> Enum.map(fn ([cell | y]) ->
                  if cell?(cell) do
                    x = Enum.at(row_num, 0)
                    y = Enum.at(y, 0)
                    Cell.new(state: cell, location: { x, y })
                  end
               end)
    |> Enum.filter(&(&1 != nil))
    |> Enum.reverse
  end

  def cell?(string) do
    string == "*" || string == "o"
  end

  def cell_for_location(map, {x, y}) do
    row = Enum.at(map, x)
    if row != nil do
      state = Enum.at(row, y)
      Cell.new(state: state, location: {x, y})
    else
      nil
    end
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

    Enum.map(neighbors, &(cell_for_location(map, &1)))
    |> Enum.filter(&(&1 != nil))
  end
end
