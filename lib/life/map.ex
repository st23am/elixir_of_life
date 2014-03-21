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
    string == "D" || string == "L"
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